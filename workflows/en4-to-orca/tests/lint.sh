#!/bin/bash
# Smoke test: verify script syntax only (no live HPC paths needed).
# Full integration test requires MareNostrum5 access (esarchive, GPFS, SOSIE).
set -e

SCRIPT="$(dirname "$0")/../scripts/interpolate_en4.2.2_to_ORCA.sh"

if [ ! -f "$SCRIPT" ]; then
    echo "❌ Script not found: $SCRIPT"
    exit 1
fi

bash -n "$SCRIPT"
echo "✅ Syntax check passed: interpolate_en4.2.2_to_ORCA.sh"
