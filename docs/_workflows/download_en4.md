# Download and Reformat EN4 Ocean Data (`download_en4`)

**Domain**: ocean-climate  
**Maintainer**: @vlapin  
**Platform**: HPC (MareNostrum5)  

---

## Purpose
Download and reformat EN4 ocean temperature/salinity data for EC-Earth experiment initialization.


**When to use:** Preparing oceanic initial conditions or verification data for EC-Earth runs on MareNostrum 5.



**When not to use:** High-resolution regridding is required without SOSIE interpolation tools.


---

## Lifecycle & Validation Status

| Dimension | Status |
|:----------|:-------|
| Documentation | `reviewed` |
| Software Validation | `passed` |
| Scientific Validation | `required` |
| Reproducibility | `unverified` |
| Infrastructure | `current` |
| Maintenance | `current` |

---

## Dependencies & Environment


### Software Dependencies

- **curl** [system]

- **netcdf** (version: `4.7`) [module]

- **cdo** [module]

- **sosie** [module]




- **Scheduler**: SLURM


---

## Inputs & Outputs


*No external inputs required.*



### Outputs

- `en4_formatted.nc` (netcdf): Reformatted EN4 data on native grid.



---

## Script Implementation


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
cdo -f nc copy ./data/en4_raw/*.gde ./data/en4/en4_formatted.nc
```


---

## Evidence & Verification


- **Claim**: The script downloads EN4 archive and reformats with CDO.
  - *Source*: `workflows/prediction-data/scripts/download_en4.sh` (lines: 10-12)
  - *Confidence*: high (Trust Level: `T0`)

- **Claim**: Choice of netcdf/4.6 vs 4.7: MareNostrum5 compatibility; netcdf/4.9 causes segfaults in SOSIE.
  - *Source*: `workflows/prediction-data/metadata.yaml` (lines: 40-48)
  - *Confidence*: high (Trust Level: `T2`)




## References

- [https://www.metoffice.gov.uk/hadobs/en4/](https://www.metoffice.gov.uk/hadobs/en4/)

