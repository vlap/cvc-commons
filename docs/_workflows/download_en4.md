# download_en4

**Owner**: @vlapin
**Status**: ⚪ Experimental

## Purpose
Download and reformat EN4 ocean data for EC-Earth experiments.

## Decision Context

- **Choice of netcdf/4.7**: MareNostrum5 compatibility; netcdf/4.9 causes segfaults in SOSIE.
  *Validated*: 2026-05-01 by @vlapin


## Dependencies
- curl- netcdf/4.7- cdo

## Tools
- sosie

## Inputs/Outputs
### Outputs
- `en4_formatted.nc` (netcdf): Reformatted EN4 data on native grid.


## Environment
- **HPC**: MareNostrum5
- **HPC Validation**: ☑️ Untested

## Usage
```bash
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

```

## Validation
- **Lint**: [results](tests/lint.sh)
- **Status**: ⚪ Experimental

---

*Last updated*: None