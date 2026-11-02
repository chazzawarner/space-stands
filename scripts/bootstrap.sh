#!/usr/bin/env bash
set -euo pipefail

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
task_cache_dir="${UV_CACHE_DIR:-/tmp/space-stands-uv-cache}"

cd "$project_root"
UV_CACHE_DIR="$task_cache_dir" uv sync --frozen
UV_CACHE_DIR="$task_cache_dir" uv run space-stands init

if [[ -n "${SPACE_STANDS_MANIFEST:-}" ]]; then
  UV_CACHE_DIR="$task_cache_dir" uv run space-stands ingest-manifest "$SPACE_STANDS_MANIFEST"
fi

echo "space-stands is ready. Copy authorised PDFs into the printed corpus directory."

