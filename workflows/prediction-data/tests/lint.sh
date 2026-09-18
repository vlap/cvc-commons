#!/bin/bash
# Run ShellCheck on scripts
shellcheck ./workflows/prediction-data/scripts/download_en4.sh || exit 1