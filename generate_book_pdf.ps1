# Strip any PATH entries containing 'claude' or ending in .exe (prevents MiKTeX
# treating claude.exe as a directory when scanning PATH)
$env:PATH = ($env:PATH -split ';' | Where-Object { $_ -notmatch 'claude' -and $_ -notmatch '\.exe' }) -join ';'
Set-Location 'C:\Users\hamil\Downloads\files2'

# Output file base name (no spaces — rename at the end)
$base = 'zero_copy_book'

# Ordered list of source files — Executive Briefing excluded
$files = @(
  '00_introduction.md',
  '01_chapter_zero_copy_necessity.md',
  '02_chapter_data_gravity_egress_economics.md',
  '03_chapter_digital_sovereignty.md',
  '04_chapter_three_integration_planes.md',
  '05_chapter_zero_copy_data_layer.md',
  '06_Multi_Cloud_Resilient_Integration.md',
  '07_chapter_zero_copy_event_layer.md',
  '08_chapter_security_by_design.md',
  '09_chapter_integration_fabrics.md',
  '10_chapter_network_aware_topologies.md',
  '11_chapter_observability_lineage_audit.md',
  '12_chapter_business_continuity_disaster_recovery.md',
  '13_chapter_sovereign_operating_model.md',
  '14_chapter_skills_culture_talent.md',
  '15_chapter_maturity_model.md',
  '16_chapter_architectural_blueprints.md',
  '17_chapter_industry_specific_patterns.md',
  '18_chapter_case_studies.md',
  '19_chapter_ai_analytics.md',
  '20_chapter_fully_sovereign_enterprise.md',
  'appendix_marker.md',
  'ibm_technologies.md',
  'open_source_technologies.md'
)

$pandocArgs = $files + @(
  '--include-in-header=preamble.tex',
  '--include-after-body=postamble.tex',
  '--lua-filter=strip_relative_links.lua',
  '--lua-filter=index_filter.lua',
  '--toc', '--toc-depth=2',
  '--resource-path=.',
  '-V', 'geometry:margin=1in',
  '-V', 'fontsize=11pt',
  '-V', 'papersize=a4',
  '-V', 'title=Zero-Copy Integration: Architecture for the Fragmented Enterprise',
  '-V', 'author=Alan Hamilton',
  '-V', 'date=2026',
  '-t', 'latex',
  '--pdf-engine=lualatex',
  '-s',
  '-o', "$base.tex"
)

Write-Host "Step 1: Generating LaTeX with pandoc..."
& pandoc @pandocArgs 2>&1
if ($LASTEXITCODE -ne 0) { Write-Host "ERROR: Pandoc failed with exit code $LASTEXITCODE"; exit 1 }
Write-Host "LaTeX generated OK."

Write-Host "Step 2: lualatex pass 1 (generates .aux and .idx)..."
& lualatex -interaction=nonstopmode -halt-on-error "$base.tex" | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: lualatex pass 1 failed. Last 40 lines of log:"
    if (Test-Path "$base.log") { Get-Content "$base.log" | Select-Object -Last 40 }
    exit 1
}
Write-Host "lualatex pass 1 OK."

Write-Host "Step 3: makeindex (builds the index)..."
& makeindex "$base.idx" 2>&1
Write-Host "makeindex exit code: $LASTEXITCODE"

Write-Host "Step 4: lualatex pass 2 (includes index and TOC)..."
& lualatex -interaction=nonstopmode "$base.tex" | Out-Null
Write-Host "lualatex pass 2 exit code: $LASTEXITCODE"

Write-Host "Step 5: lualatex pass 3 (resolves cross-references)..."
& lualatex -interaction=nonstopmode "$base.tex" | Out-Null
Write-Host "lualatex pass 3 exit code: $LASTEXITCODE"

$dest = 'Zero-Copy Integration Book.pdf'
if (Test-Path "$base.pdf") {
    Copy-Item "$base.pdf" $dest -Force
    $size = (Get-Item $dest).Length / 1MB
    Write-Host ("SUCCESS: '$dest' generated ({0:N1} MB)" -f $size)
} else {
    Write-Host "ERROR: PDF not found after build."
    exit 1
}
