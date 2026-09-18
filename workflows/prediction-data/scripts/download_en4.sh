#!/bin/bash
# Purpose: Download EN4 ocean data for EC-Earth experiments.
# Dependencies: curl, netcdf/4.7, cdo
# Input: None
# Output: ./data/en4/en4_formatted.nc

set -euo pipefail

module load netcdf/4.7
curl -o ./data/en4_raw.tar.gz "https://www.metoffice.gov.uk/hadobs/en4/data/en4-2.1.1.tar.gz"
tar -xzf ./data/en4_raw.tar.gz -C ./data/
cdo -f nc copy ./data/en4_raw/*.gde ./data/en4/en4_formatted.nc# Intake Agent Test: Added comment for triggering
# Re-trigger: Intake Agent
# Re-trigger Intake Agent
