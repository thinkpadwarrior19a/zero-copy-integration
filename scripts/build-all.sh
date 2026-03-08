#!/usr/bin/env bash
# build-all.sh — Build DOCX, ePub, and PDF from Zero-Copy Integration
# Usage: bash scripts/build-all.sh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="${REPO_ROOT}/output"
mkdir -p "${OUT_DIR}"

# Add tools to PATH
export PATH="/c/Users/hamil/AppData/Local/Pandoc:/c/Users/hamil/AppData/Local/Programs/MiKTeX/miktex/bin/x64:${PATH}"

# Collect chapter files in order
# copyright.md first, then introduction, then numbered chapters, then chapter 20
mapfile -t CHAPTERS < <(
  echo "${REPO_ROOT}/copyright.md"
  echo "${REPO_ROOT}/00_introduction.md"
  ls "${REPO_ROOT}"/[0-1][0-9]_chapter_*.md "${REPO_ROOT}"/[0-1][0-9]_Multi_*.md 2>/dev/null | sort
  echo "${REPO_ROOT}/20_chapter_fully_sovereign_enterprise.md"
)

echo "========================================="
echo "  Zero-Copy Integration — Full Build"
echo "========================================="
echo "Found ${#CHAPTERS[@]} source files"
echo ""

# ─────────────────────────────────────────────
# 1. DOCX Build
# ─────────────────────────────────────────────
echo "[1/3] Building DOCX..."
pandoc \
  "${CHAPTERS[@]}" \
  --metadata-file="${REPO_ROOT}/config/metadata-docx.yaml" \
  --metadata title="Zero-Copy Integration" \
  --metadata subtitle="Architecture for the Fragmented Enterprise" \
  --lua-filter="${REPO_ROOT}/config/docx-enhancements.lua" \
  --from=markdown+autolink_bare_uris \
  --to=docx \
  --standalone \
  --resource-path="${REPO_ROOT}" \
  --toc --toc-depth=2 \
  --output="${OUT_DIR}/Zero-Copy-Integration.docx"
echo "  -> ${OUT_DIR}/Zero-Copy-Integration.docx"

# ─────────────────────────────────────────────
# 2. ePub Build
# ─────────────────────────────────────────────
echo "[2/3] Building ePub..."
pandoc \
  "${CHAPTERS[@]}" \
  --metadata-file="${REPO_ROOT}/config/metadata-epub.yaml" \
  --metadata title="Zero-Copy Integration" \
  --metadata subtitle="Architecture for the Fragmented Enterprise" \
  --lua-filter="${REPO_ROOT}/config/epub-enhancements.lua" \
  --css="${REPO_ROOT}/config/epub-style.css" \
  --from=markdown+autolink_bare_uris \
  --to=epub3 \
  --standalone \
  --resource-path="${REPO_ROOT}" \
  --toc --toc-depth=2 \
  --split-level=1 \
  --output="${OUT_DIR}/Zero-Copy-Integration.epub"
echo "  -> ${OUT_DIR}/Zero-Copy-Integration.epub"

# ─────────────────────────────────────────────
# 3. PDF Build (via XeLaTeX)
# ─────────────────────────────────────────────
echo "[3/3] Building PDF (this may take a few minutes)..."
pandoc \
  "${CHAPTERS[@]}" \
  --metadata-file="${REPO_ROOT}/config/metadata-pdf.yaml" \
  --metadata title="Zero-Copy Integration" \
  --metadata subtitle="Architecture for the Fragmented Enterprise" \
  --lua-filter="${REPO_ROOT}/config/index-filter.lua" \
  --include-in-header="${REPO_ROOT}/config/pdf-preamble.tex" \
  --from=markdown+autolink_bare_uris \
  --to=latex \
  --standalone \
  --pdf-engine=xelatex \
  --resource-path="${REPO_ROOT}" \
  --output="${OUT_DIR}/Zero-Copy-Integration.pdf"
echo "  -> ${OUT_DIR}/Zero-Copy-Integration.pdf"

echo ""
echo "========================================="
echo "  Build complete!"
echo "========================================="
echo "  DOCX: ${OUT_DIR}/Zero-Copy-Integration.docx"
echo "  ePub: ${OUT_DIR}/Zero-Copy-Integration.epub"
echo "  PDF:  ${OUT_DIR}/Zero-Copy-Integration.pdf"
echo "========================================="
