# 1. NetCDF 4.7 for EN4 Preprocessing and SOSIE

- **Status:** Accepted
- **Date:** 2026-05-01
- **Author:** @vlapin

## Context
When processing EN4 ocean data with CDO and SOSIE interpolation tools on MareNostrum 5, newer NetCDF libraries (`netcdf/4.9`) introduced ABI incompatibilities causing segmentation faults during bilinear interpolation of native ocean grids.

## Decision
Pin the environment module to `netcdf/4.7` on MareNostrum 5 for EN4 preprocessing pipelines.

## Evidence & Validation
- MareNostrum 5 test runs with SOSIE completed successfully using `netcdf/4.7`.
- Segfaults verified and reproduced when using `netcdf/4.9`.

## Consequences
- Requires loading `module load netcdf/4.7` in execution scripts.
- Will be re-evaluated when SOSIE is updated for newer NetCDF releases.
