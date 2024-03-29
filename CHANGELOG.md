# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased](https://github.com/ImaanBontle/apo-phot/commits/compare/v1.0.1...HEAD)

### Planned

### Added

## [v1.0.1](https://github.com/ImaanBontle/apo-phot/commits/compare/v1.0.0...v1.0.1) - 2023-06-02

### What Changed 🚀

Minor bugfixes and documentation updates. Added new column to summary.fits (see README.md).

### 🐛 Bug Fixes

- Fixed missed pointings in summary tables @ImaanBontle (#88)

### 📄 Documentation

- fix: Major update to README @ImaanBontle (#86)

> **Full Changelog**: https://github.com/ImaanBontle/apo-phot/compare/v1.0.0...v1.0.1

## [v1.0.0](https://github.com/ImaanBontle/apo-phot/commits/compare/v0.6.2...v1.0.0) - 2023-02-13

### What Changed 🚀

Major overhaul to output format. This is a **breaking change** if you were relying on the previous output format.

Units are now in nJy, column names are different, units are included in tables, a summary file for all bands and pointings has been added, and supplementary output has been categorised into RawData (results of apodised photometry calculations) and FilterData (data collected across all filters, at various stages of averaging).

An updated output README will be added in a minor release.

### ✨ New Features

- Added an abbreviated results summary file to the output @ImaanBontle (#77)

### ⚠️ Changes

- Changed flux units to nJy (previously µJy) @ImaanBontle (#78)
- Replaced the previous output file format with a more user-friendly design @ImaanBontle (#82)

### 📄 Documentation

- Added support for contributors @ImaanBontle (#79)

> **Full Changelog**: https://github.com/ImaanBontle/apo-phot/compare/v0.6.2...v1.0.0

## [v0.6.2](https://github.com/ImaanBontle/apo-phot/commits/compare/v0.6.1...v0.6.2) - 2023-01-17

### What Changed 🚀

Bug fixes

### 🐛 Bug Fixes

- Fixed bug with galaxy RA and Dec not updating correctly in the summary files (#48)

### ⚠️ Changes

- Output files are now sorted by ID (#51)

**Full Changelog**: https://github.com/ImaanBontle/apo-phot/compare/v0.6.1...v0.6.2

## [v0.6.1](https://github.com/ImaanBontle/apo-phot/commits/compare/v0.6.0...v0.6.1) - 2023-01-16

### What Changed 🚀

Fixed an issue where the flux was converted incorrectly.

### 🐛 Bug Fixes

- Fixed incorrect flux conversions in the output files (#45)

**Full Changelog**: https://github.com/ImaanBontle/apo-phot/compare/v0.6.0...v0.6.1

## [v0.6.0](https://github.com/ImaanBontle/apo-phot/commits/compare/v0.5.0...v0.6.0) - 2023-01-11

### What Changed 🚀

Output files now also include flux-converted photometry.

### ✨ New Features

- Added flux-converted photometry to the output files (#38)

### ⚠️ Changes

- Added units to the output files and improved the naming scheme (#35)

### 📄 Documentation

- Updated to a new changelog system (#32)
- Added new issue templates (bug report and feature request) (#33)

**Full Changelog**: https://github.com/ImaanBontle/apo-phot/compare/0.5.0...v0.6.0

## [v0.5.0](https://github.com/ImaanBontle/apo-phot/commits/compare/v0.4.0...v0.5.0)

- Optimised code slightly.
- Cleaned up strings inside tables and dictionaries, to make them more readable.
- Added nominal pixel area and average flux per area per count to output image summary file (taken from image headers).
- Renamed Offset_summary.fits to Summary.fits, to better reflect its' intended purpose.
- Reworked most column headings to be more intuitive to the end-user.

## [v0.4.0](https://github.com/ImaanBontle/apo-phot/commits/compare/v0.3.1...v0.4.0)

- Catalogue visit loop now depends on length of visit list, so that you can run singular/multiple visit catalogues without problem
- Added aperture area to visit output
- New utility notebook for exploring slit-loss correction files
- Moved data import inside main codeblock and repurposed initial section into user-defined variable names & lists. This prevents memory leaks due to large image files being loaded into RAM prior to code execution. Now, they are loaded once during execution, manipulated, and then overwritten in the next loop, so that only one image is ever in circulation. Finally, when the code ends, all internal variables are cleared from RAM as a byproduct of how python handles local variables contained inside functions, ensuring that the final image is also cleared from memory. Altogether should make massive images (tens of GBs) more feasible on local machines.
- Rearranged internal code to accommodate the above change, renaming several objects to be more intuitive i.e. disposed of confusing "Longlist" dictionary in favour of homogenised "Catalogue", "AlignCat" and "ImageDict" objects. Opens door to reducing size of branching paths in future so that code is more readable.

## [v0.3.1](https://github.com/ImaanBontle/apo-phot/commits/compare/v0.3.0...v0.3.1)

- Cleaned repository, added separate utilities, scripts, and logs folders.
- Added utility notebook 'Prep_Apertures.ipynb' which prepares aperture corners for apodised photometry.
- Re-implemented source co-ordinates in the apertures-provided case. Annuli are now centred on the source again.

## [v0.3.0](https://github.com/ImaanBontle/apo-phot/commits/compare/v0.2.0...v0.3.0)

- Added aperture corners to output in all cases, for easier cross-referencing with input catalogues.
- Added auto-overwrite for calculations, to save time. May add flag later.- Added ability to differentiate between physical and illuminated input apertures. If illuminated, the aperture will not be recalculated and instead code proceeds directly to the photometry. ApFlag updated appropriately (False: no apertures provided, "Physical": physical apertures provided, "Illuminated": illuminated apertures provided).
- Implemented manual aperture angle calculation if the apertures are provided; more accurate than using planned angles.

## [v0.2.0](https://github.com/ImaanBontle/apo-phot/commits/compare/v0.1.2...v0.2.0)

- Re-added missing scripts
- Minor tweaks to code efficiency
- Prepared environment to accept necessary files (no changes to images yet)
- Code accepts a FITS table with RA/Dec of each corner of the aperture, followed by the source ID and then the aperture angle
- Branched main code into two different routes at execution time by adding a flag-check for whether aperture coordinates have been provided
- Subdivided most of the original main function into smaller sub-functions so the main function is dedicated to handling the different input cases
- Restored a temporary (incorrect) alignment file for datasets where apertures are already provided. Needs an urgent feature branch for implementing whether or not to re-align images based on presence of target acquisition.
- Temporarily commented out source RA, Dec for apertures given. Will need to be implemented in a later commit.
- Some galaxies have non-integer IDs (bad shutters), so have temporarily limited range of loop while testing.
- Added source, alignment and working directories as variables, so this can be customised by the user.
- Added image file preview, so user can decide which extensions to include. Unfortunately, no way to make this truly dynamic yet.
- Added alignment flag for when user does not provide alignment stars
- Added exception for when user does not list any custom ID annuli, so the code runs without error
- Added third errflag option (None) which disables photometry error estimate. This should save time on very large images.
- Removed masked array from image arrays, as this slows down computation and is not needed except for image statistics. Images should implement this separately if still needed
- Implemented cutout postage stamps to speed up photometry calculations
- Switched background flux calculation to a flux per square pixel rather than a mean, so that the calculation is performed with exact pixel accuracy (otherwise photutils uses pixel centres)
- Renamed AlignFlag values to make more intuitive sense

## [v0.1.2](https://github.com/ImaanBontle/apo-phot/commits/compare/v0.1.1...v0.1.2)

- Annulus sizes now adjust dynamically to the image's pixel scale, with the first image's pixel scale used as reference.
- Added script to update changelog with latest changes.
- Updated README.

## [v0.1.1](https://github.com/ImaanBontle/apo-phot/commits/compare/v0.1.0...v0.1.1)

- Added correct annulus sizes for each image based on differing pixel scales.

## v0.1.0

- Added edited description from repository readme to notebook.
- Removed Gaia section.
