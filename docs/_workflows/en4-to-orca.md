# Interpolate EN4.2.2 to ORCA Grid (`en4-to-orca`)

**Domain**: ocean-climate  
**Maintainer**: @vlapin  
**Platform**: HPC (MareNostrum5)  

---

## Purpose
Interpolate EN4.2.2 monthly ocean temperature and salinity profiles from the UK Met Office observational grid to the ORCA1 or ORCA025 grid required by NEMO-based EC-Earth ocean nudging.



**When to use:** Preparing oceanic nudging data (temperature/salinity restoring fields) for EC-Earth3 seasonal or decadal prediction runs on MareNostrum5.




**When not to use:** ORCA025 grid is required and SOSIE weights for that grid are not present in the standard esarchive path.



---

## Lifecycle & Validation Status

| Dimension | Status |
|:----------|:-------|
| Documentation | `proposed` |
| Software Validation | `not-run` |
| Scientific Validation | `required` |
| Reproducibility | `unverified` |
| Infrastructure | `current` |
| Maintenance | `current` |

---

## Dependencies & Environment


### Software Dependencies

- **NCO** (version: `4.9.3`) [module]

- **CDO** (version: `1.9.8`) [module]

- **sosie3.x** (version: `3.x`) [module]




- **Scheduler**: LSF


---

## Inputs & Outputs


### Inputs

- `sourcedir` (directory): Directory containing EN4.2.2 monthly NetCDF files in sub-dirs by variable (thetao/, so/).


- `mask` (file): NEMO mesh-mask file for the target ORCA grid (defines land-sea mask, grid coordinates, and cell metrics).


- `outdir` (directory): Output directory on GPFS for interpolated yearly files.

- `yearb` (integer): First year to process (inclusive).

- `yeare` (integer): Last year to process (inclusive).

- `grid` (string): Target grid identifier (ORCA1 or ORCA025).




### Outputs

- `temp_sal_y${YEAR}.nc` (netcdf): Merged temperature (votemper) and salinity (vosaline) on the ORCA grid, one file per year. Transferred to outdir via dtmv on transfer1.




---

## Script Implementation


*See script files in repository.*


---

## Evidence & Verification


- **Claim**: Script reads EN4.2.2 NetCDF files from /esarchive and writes interpolated yearly files to /gpfs/projects/bsc32.

  - *Source*: `workflows/en4-to-orca/scripts/interpolate_en4.2.2_to_ORCA.sh` (lines: 35-37)
  - *Confidence*: high (Trust Level: `T0`)

- **Claim**: SOSIE namelist templates (namelist_en4.2.2_thetao, namelist_en4.2.2_so) must be present in the working directory (copied from the script directory at runtime).

  - *Source*: `workflows/en4-to-orca/scripts/interpolate_en4.2.2_to_ORCA.sh` (lines: 47)
  - *Confidence*: high (Trust Level: `T0`)

- **Claim**: Temperature is converted from Kelvin to Celsius via 'cdo subc,273.15' and renamed to NEMO variable votemper.

  - *Source*: `workflows/en4-to-orca/scripts/interpolate_en4.2.2_to_ORCA.sh` (lines: 99-100)
  - *Confidence*: high (Trust Level: `T0`)

- **Claim**: NetCDF/4.9 causes segfaults in SOSIE on MareNostrum5. Use NCO/4.9.3 and CDO/1.9.8 as validated module versions.

  - *Source*: `docs/decisions/0001-netcdf-version.md` (lines: )
  - *Confidence*: high (Trust Level: `T2`)




## References

- [https://www.metoffice.gov.uk/hadobs/en4/](https://www.metoffice.gov.uk/hadobs/en4/)

- [https://confluence.ecmwf.int/display/FCST/ORCA+grids](https://confluence.ecmwf.int/display/FCST/ORCA+grids)

