# Strip any PATH entries containing 'claude' or ending in .exe
$env:PATH = ($env:PATH -split ';' | Where-Object { $_ -notmatch 'claude' -and $_ -notmatch '\.exe' }) -join ';'
Set-Location 'C:\Users\hamil\Downloads\files2'

$out = 'Zero-Copy Integration Book.epub'

# Ordered list of source files — Executive Briefing excluded
$files = @(
  'copyright.md',
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
  '--to', 'epub3',
  '--toc',
  '--toc-depth=2',
  '--split-level=1',
  '--epub-cover-image=images/Zero-Copy-Integration-Cover-Image.png',
  '--css=epub.css',
  '--lua-filter=strip_relative_links.lua',
  '--resource-path=.',
  '--metadata', 'title=Zero-Copy Integration: Architecture for the Fragmented Enterprise',
  '--metadata', 'author=Alan Hamilton',
  '--metadata', 'date=2026',
  '--metadata', 'lang=en-GB',
  '--metadata', 'description=A comprehensive guide to zero-copy integration architecture for the fragmented enterprise.',
  '--metadata', 'publisher=Alan Hamilton',
  '--metadata', 'rights=Copyright 2026 Alan Hamilton. All rights reserved.',
  '-o', $out
)

Write-Host "Generating EPUB..."
& pandoc @pandocArgs 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: pandoc failed with exit code $LASTEXITCODE"
    exit 1
}

if (Test-Path $out) {
    $size = (Get-Item $out).Length / 1MB
    Write-Host ("SUCCESS: '$out' generated ({0:N1} MB)" -f $size)
} else {
    Write-Host "ERROR: EPUB not found after build."
    exit 1
}
