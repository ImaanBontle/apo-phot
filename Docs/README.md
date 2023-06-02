<!--About-->
# About This README <a id="top"></a>

*The README explains how the apodised photometry output tables are structured, what type of data each table contains and where the most important values can be found.*

The motivation for the apodised fluxes from the NIRCam images, measuring the broadband light over exactly the same area of the sky (as probed by the MSA shutter), is to check the integrated spectral flux to test the flux calibration, and also to calculate the equivalent width of emission lines even in the cases where the continuum in the spectrum is weak or undetected.

We note that to use this data, one should first "undo" the slitloss correction applied to the NIRSpec-extracted spectra. For HST-Deep, these slitlosses can be found on [Confluence][HST-Deep-pathloss] (these are files used in [Curti et al. 2023][curti-et-al-2023]'s slitloss correction). In v3.0 of the spectroscopy, the slitloss correction assumed an off-centre point-source, and used the files '*\*v0\_point*'. These slitloss corrections are greater than 1, and hence the calibrated spectrum needs to be divided by this number for each wavelength.

There is also a second correction that needs to be applied when undoing the slitloss corrections to account for the slightly larger PSF of NIRSpec than NIRCam at a given wavelength (due to diffraction at the aperture). We have quantified that this is on average a fractional correction of $f_{\lambda} = 0.0494 \lambda + 0.8538$ where wavelength is provided in microns. After dividing the spectrum by the slitloss corrections, one would need to multiply by this fractional correction. Once this is done, the NIRSpec spectrum convolved with the filter transmission bandpass should return the same flux as seen in the apodised broadband image (subject to the correct flux calibration). Further, the fractional contribution of each emission line to the broadband apodised flux can be determined, and hence the continuum can be inferred and the equivalent width calculated for each line.

<!--Table of Contents-->
# Table of Contents <a id="contents"></a>

*Jump to any of the sections in this README using the table of contents below.*

This document has the following structure:

- First, [an overview](#overview) is provided of each of the files and the types of data they contain.
- Then, this is followed by a more [detailed breakdown](#files) of each of the files. This breakdown includes an exhaustive list of the values stored in each column, their units, the naming convention for the files, and other relevant information.

In most cases, the average reader should focus primarily on the [overview](#overview) and [results summary](#summary) sections and ignore the rest.

- [Overview](#overview)
- [File Details](#files)
	- [Abridged Summary Table](#summary)
	- [Unabridged Summary Table](#summary-detailed)
	- [Results per Pointing](#results)
	- [Raw Output Files](#details)
	- [Parameters List](#params)

<!--Overview of the Files-->
# Overview of Output Files <a id="overview"></a>

*This section provides an overview of the output files and how the data for each was calculated. See the [next section](#files) for a detailed breakdown of contents of these files.*

For each galaxy, the apodised photometry from the NIRCam images (the total flux passing through the MSA slit) is calculated. This is done separately for each filter and each pointing. Afterwards, these fluxes are collected into a master table of filters for each pointing. These are then further reduced by averaging across all available pointings for each filter to produce an average apodised flux per galaxy per photometric band. Finally, the values for each band are compiled into a single summary table for ease of access, with this including both an abridged and unabridged format.

This process is repeated separately for each dataset and the results for each are stored in dedicated folders (e.g. *SMACS-ERC* or *HST-Deep*). Within each folder, there are the master output files (*summary.fits*), as well as a pair of subfolders (*FilterData* and *RawData*) containing various fits tables representing each step of the process.

The breakdown of each table is:

1. [An abridged results file](#summary) (i.e. *summary.fits*) &mdash; ***This is the most relevant file for the average reader.*** It contains the final apodised fluxes for each filter (where available) and for each galaxy in the dataset, averaged across all pointings, as well as the total number of photometric bands with a signal-to-noise ratio greater than or equal to 5 (5-sigma detection).
2. [An unabridged results file](#summary-detailed) (i.e. *FilterData/summary_detailed.fits*) &mdash; This includes the same columns as in the abridged file, but with the additional inclusion of the background flux estimations and the total non-background-subtracted fluxes through the filters.
3. [A detailed results file for each pointing](#results) (e.g. *FilterData/\<pointing\>_summary.fits*) &mdash; These tables, provide identical information to the unabridged results files, but for the given pointing only i.e. the tables provide the apodised fluxes, the background estimations and the non-background-subtracted flux totals for each filter without averaging across each pointing. If you are concerned about variation in the slitloss between pointings (e.g. if an object lies close to a slit edge), then these tables may be more useful to you than the abridged results file.
4. [Raw output files for each filter](#details) (e.g. *RawData/F400W_\<pointing\>*) &mdash; These files contain the raw output used to compile the summary catalogues. Here, detailed information is provided for each available filter of a given pointing, including the pixel coordinates of the source and the aperture, the aperture dimensions and the annulus radii used for background estimates. Most of this data shouldn't be relevant except when needing to follow up on the results for individual sources and/or their slitmask data.
5. [A parameters file](#params) (i.e. *FilterData/parameters.fits*) &mdash; This file summarises all the parameters used for the original flux calculations, including the relevant conversion and rescaling factors. These are provided mostly for debugging purposes.

<div align="right">

[[Back to Contents](#contents)]

</div>

<!--Detailed File Breakdowns-->
# File Types <a id="files"></a>

*This section contains a detailed breakdown for each FITS table. For details regarding the error estimations, see the [AstroPy Documentation][astropy-error-link].*

<!--Results Summary-->
## Abridged Summary Table <a id="summary"></a>

This table contains the average apodised flux per filter (averaged across the available MSA pointings) for each galaxy. The file is named *summary.fits*. Fluxes are provided in nJy, and are provided separately for each filter. The following columns are included:

- **ID:** the ID of the galaxy.
- **RA:** the right ascension of the galaxy in degrees.
- **Dec:** the declination of the galaxy in degrees. 
- **Flux**: the background-subtracted flux passing through the aperture, in units of nJy.
- **Error**: an estimate of the error in the flux, in units of nJy.
- **Total High SNR Bands (5 Sigma)**: the total number of photometric bands with signal-to-noise greater than or equal to 5 (5-sigma detection).

<div align="right">

[[Back to Contents](#contents)]

</div>

<!--Detailed Results Summary-->
## Unabridged Summary Table <a id="summary-detailed"></a>

This table contains the average apodised flux per filter (averaged across the available MSA pointings) for each galaxy, similarly to the [abridged results file](#summary). The file is named *summary_detailed.fits* and is located inside the *FilterData* subfolder. Fluxes are provided in nJy and flux densities in MJy/sr, and are provided separately for each filter. The following columns are included:

- **ID:** the ID of the galaxy.
- **RA:** the right ascension of the galaxy in degrees.
- **Dec:** the declination of the galaxy in degrees. 
- **Total Flux Density:** the total flux density passing through the aperture, in units of MJy per steradian.
- **Background Density/Pixel:** an estimate of the background flux density in the region surrounding the galaxy, in units of MJy per steradian per pixel squared.
- **Actual Flux Density:** the background-subtracted flux density passing through the aperture, in units of MJy per steradian.
- **Flux Density Error:** an estimate of the error in the actual flux density, in units of MJy per steradian.
- **Total Flux:** the total flux passing through the aperture, in units of nJy.
- **Background Flux:** an estimate of the background flux in the region surrounding the galaxy, in units of nJy per pixel squared.
- **Actual Flux:** the background-subtracted flux passing through the aperture, in units of nJy.
- **Flux**: the background-subtracted flux passing through the aperture, in units of nJy.
- **Error**: an estimate of the error in the flux, in units of nJy.

<div align="right">

[[Back to Contents](#contents)]

</div>

<!--Results per Pointing-->
## Results per Pointing <a id="results"></a>

These tables contain the most relevant results for each of the galaxies for a given pointing. The files are named *\<pointing\>_summary.fits*, where *\<pointing\>* refers to the name of the relevant photometric filter (e.g. *7*). These tables are included inside the *FilterData* folder. Flux densities are provided in MJy/sr and fluxes are provided in nJy, and are reported separately for each filter.

Each table contains the following columns:

- **ID:** the ID of the galaxy.
- **RA:** the right ascension of the galaxy in degrees.
- **Dec:** the declination of the galaxy in degrees. 
- **Angle:** the angle of the slit on the sky in degrees.
- **Total Flux Density:** the total flux density passing through the aperture, in units of MJy per steradian.
- **Background Density/Pixel:** an estimate of the background flux density in the region surrounding the galaxy, in units of MJy per steradian per pixel squared.
- **Actual Flux Density:** the background-subtracted flux density passing through the aperture, in units of MJy per steradian.
- **Flux Density Error:** an estimate of the error in the actual flux density, in units of MJy per steradian.
- **Total Flux:** the total flux passing through the aperture, in units of nJy.
- **Background Flux:** an estimate of the background flux in the region surrounding the galaxy, in units of nJy per pixel squared.
- **Actual Flux:** the background-subtracted flux passing through the aperture, in units of nJy.
- **Flux**: the background-subtracted flux passing through the aperture, in units of nJy.
- **Error**: an estimate of the error in the flux, in units of nJy.

<div align="right">

[[Back to Contents](#contents)]

</div>

<!--Raw Output Files-->
## Raw Output Files <a id="details"></a>

These tables contain detailed calculations for every available pointing in each filter. The following naming convention is used: *\<filter\>_\<pointing\>.fits*, where *\<filter\>* refers to the name of the relevant photometric filter (e.g. *F200W*) and *\<pointing\>* refers to the internal name used for the pointing (e.g. *12* or *c1-2e2n3-G395M-F290LP*). These files are contained within the *RawData* folder. Offsets are provided as decimal percentages, coordinates and areas are provided in pixels, flux densities are provided in MJy/sr and fluxes are provided in nJy.

The following columns are contained in each table:

- **ID:** the ID of the galaxy.
- **RA:** the right ascension of the galaxy in degrees.
- **Dec:** the declination of the galaxy in degrees.
- **Angle:** the aperture angle in degrees.
- **Offset:** the relative offset of the galaxy from the corner of the slit, expressed as fractional percentages of the slit dimensions. Only included in cases where the slit coordinates are not provided.
- **Source Pixel:** the x and y pixel coordinates of the galaxy.
- **Source Shifted:** the x and y pixel coodinates of the galaxy, after correcting for any uniform shift between the image and the astrometry.
- **Source Scaled:** the x and y pixel coordinates of the galaxy, after correcting for any uniform shift and scaling offset between the image and the astrometry.
- **Aperture Pixel, Shifted and Scaled:** the x and y pixel coordinates of the centre of the aperture for the same three cases as for the galaxy.
- **Aperture Width and Height:** the width and height of the aperture, expressed in pixels.
- **Aperture Corners:** the x and y pixel coordinates of the four aperture corners, after correcting any uniform shift and scaling offset between the image and the astrometry.
- **Aperture Area:** the area of the aperture in pixels squared. This is used to scale the background flux estimate to match the size of the aperture.
- **Annulus Radii:** the inner and outer radii of the annulus used to estimate the background noise in the region surrounding the galaxy, expressed in pixels from the annulus centre.
- **Total Density:** the total flux density passing through the aperture, in units of MJy per steradian.
- **Background Density/Pixel:** an estimate of the background flux density in the region surrounding the galaxy, in units of MJy per steradian per pixel squared.
- **Actual Density:** the background-subtracted flux density passing through the aperture, in units of MJy per steradian.
- **Density Error:** an estimate of the error in the actual flux density, in units of MJy per steradian.
- **Total Flux:** the total flux passing through the aperture, in units of nJy.
- **Background Flux/Pixel:** an estimate of the background flux in the region surrounding the galaxy, in units of nJy per pixel squared.
- **Actual Flux:** the background-subtracted flux passing through the aperture, in units of nJy.
- **Flux Error:** an estimate of the error in the actual flux, in units of nJy.

<div align="right">

[[Back to Contents](#contents)]

</div>

<!--Calculation Parameters-->
## Parameters List <a id="params"></a>

This table contains supplementary information related to the photometry calculations for each filter. This file is always named *parameters.fits* and is located within the *FilterData* folder.

The following columns are included in the output:

- **Image (Filter):** the name of the filter.
- **Shift Correction Factor:** the x and y pixel shift applied to each galaxy before calculating the photometry, in order to correct for any uniform offsets between the image and the astrometry. This step is enabled with a flag and is defined as the average shift of all the sources from their best-fit flux centroids ([as determined by AstroPy][astropy-centroid-link]). When disabled, these values are zero.
- **Rescale Factor:** similarly to the Shift Correction Factor, this is the multiplicative x and y pixel rescaling applied to each galaxy to correct for any image scaling issues. This is also enabled with a flag and is defined as the average apparent scaling of all sources away from their best-fit flux centroids, **after correcting the uniform shift**. When disabled, these values are equal to one.
- **Rescale Origin:** the x and y pixel coordinates around which the apparent scaling is centred. When disabled, these values are zero.
- **Nominal Pixel Area:** the effective pixel area of the image, in units of steradian, extracted from the image header. Used to convert from flux density to flux.

<div align="right">

[[Back to Contents](#contents)]

</div>

<!--HYPERLINKS-->
[astropy-error-link]: <https://photutils.readthedocs.io/en/stable/aperture.html#aperture-photometry-error-estimation> "Astropy Documentation on Aperture Photometry Error Estimation"
[astropy-centroid-link]: <https://photutils.readthedocs.io/en/stable/centroids.html> "AstroPy Documentation on Centroid Calculation"
[hst-deep-pathloss]: <https://s2e2.cosmos.esa.int/confluence/display/WGs/Path+loss+corrections> "HST-Deep Pathloss Corrections"
[curti-et-al-2023]: <https://ui.adsabs.harvard.edu/abs/2023MNRAS.518..425C/abstract> "The chemical enrichment in the early Universe as probed by JWST via direct metallicity measurements at z ∼ 8"
