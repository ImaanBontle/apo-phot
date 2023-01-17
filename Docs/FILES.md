<!--Table of Contents-->
# Apodised Photometry <a id="contents"></a>

The output folders contain several FITS tables containing the apodised photometry for each NIRCam filter. This README document explains how the output files are structured, what type of data they contain and where the most important data can be found.

This README has the following structure: first, an [overview](#overview) is provided for each of the files and the types of data they contain. Then this is followed by a [more detailed breakdown](#files) of each of the files, providing an exhaustive list of the values stored within, their units, the file naming convention and any other information relevant to the reader.

In most cases, readers can focus on the [overview](#overview) and [results breakdown](#results) sections and ignore the rest, as they describe files which are often not useful except under certain circumstancese.

Jump to any of the sections in this README by using the table below.

- [Overview](#overview)
- [Files](#files)
	- [Results](#results)
	- [Details](#details)
	- [Parameters](#params)

<!--Overview of the Files-->
## Overview of Output Files <a id="overview"></a>

*This section provides an overview of the output files.*

For each source appearing in a filter, the apodised photometry (the total galaxy flux passing through the MSA slit) was calculated and averaged across all the available pointings. This results in an averaged apodised flux for each photometry band. This process is repeated separately for each dataset and the results for each stored in a dedicated folder (e.g. *SMACS-ERC* or *HST-Deep*).

Within each folder, there are three types of FITS files:

1. [A summary file for each filter](#results) (e.g. *F400W_summary.fits*) - This contains the apodised fluxes averaged across all the available pointings of the MSA for a given filter. ***This is the most useful file for most readers.***
2. [A detailed breakdown for each pointing](#details) (e.g. *F400W_8.fits*) - These provide more detailed information on each observation for a given filter. Most of this information isn't relevant but is included for completeness.
3. [A separate parameters file](#params) (i.e. *parameters.fits*) - This contains all the extra information used for the flux calculations, such as conversion and rescaling factors. This is mostly relevant for debugging purposes, but can be consulted if needed.

In most cases, readers can focus on the [summary files for each filter](#results) and safely ignore the other files. These summary files contain the apodised fluxes for each galaxy, averaged across all the pointings for a given filter, while all the remaining files are supplementary in nature and likely not very interesting.

<div align="right">

[[Back to Top](#contents)]

</div>

<!--Detailed File Breakdowns-->
## File Types <a id="files"></a>

*This section contains a detailed breakdown of each FITS table.*

<!--Results per Filter-->
### Results Files <a id="results"></a>

These tables contain the most relevant results for each of the galaxies in a given filter. The files are named *\<filtername\>_summary.fits*, where *filtername* refers to the name of the relevant photometric filter (e.g. *F200W*). Flux densities are provided in mega Janskies per steradian and fluxes in micro Janskies. For more details regarding the error estimations, see the [AstroPy Documentation][astropy-error-link].

Each table contains the following columns:

- **ID:** the ID of the galaxy.
- **RA:** the right ascension of the galaxy in degrees.
- **Dec:** the declination of the galaxy in degrees.
- **Total Density:** the total flux density passing through the aperture, in units of mega Janskies per steradian.
- **Background Density/Pixel:** an estimate of the background flux density in the region surrounding the galaxy, in units of mega Janskies per steradian per pixel squared.
- **Actual Density:** the background-subtracted flux density passing through the aperture, in units of mega Janskies per steradian.
- **Density Error:** an estimate of the error in the actual flux density, in units of mega Janskies per steradian.
- **Total Flux:** the total flux passing through the aperture, in units of micro Janskies.
- **Background Flux/Pixel:** an estimate of the background flux in the region surrounding the galaxy, in units of micro Janskies per pixel squared.
- **Actual Flux:** the background-subtracted flux passing through the aperture, in units of micro Janskies.
- **Flux Error:** an estimate of the error in the actual flux, in units of micro Janskies.

<!--Results per Observation-->
### Detailed Output Files <a id="details"></a>

These tables contain detailed calculations for every available pointing in each filter. The following naming convention is used: *\<filtername\>_\<visitname\>.fits*, where *filtername* refers to the name of the relevant photometric filter (e.g.*F200W*) and *visitname* refers to the internal name used to refer to the observation (e.g. *12* or *c1-2e2n3-G395M-F290LP*. Offsets are provided as decimal percentages. Coordinates and areas are provided in pixels. Flux densities are provided in mega Janskies per steradian and fluxes in micro Janskies. For more details regarding the error estimations, see the [AstroPy Documentation][astropy-error-link].

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
- **Aperture Area:** the area of the aperture in pixels squared. This is used to scale the background estimate to the size of the aperture.
- **Annulus Radii:** the inner and outer radii of the annulus used to estimate the background noise in the region surrounding the galaxy, expressed in pixels for the annulus centre.
- **Total Density:** the total flux density passing through the aperture, in units of mega Janskies per steradian.
- **Background Density/Pixel:** an estimate of the background flux density in the region surrounding the galaxy, in units of mega Janskies per steradian per pixel squared.
- **Actual Density:** the background-subtracted flux density passing through the aperture, in units of mega Janskies per steradian.
- **Density Error:** an estimate of the error in the actual flux density, in units of mega Janskies per steradian.
- **Total Flux:** the total flux passing through the aperture, in units of micro Janskies.
- **Background Flux/Pixel:** an estimate of the background flux in the region surrounding the galaxy, in units of micro Janskies per pixel squared.
- **Actual Flux:** the background-subtracted flux passing through the aperture, in units of micro Janskies.
- **Flux Error:** an estimate of the error in the actual flux, in units of micro Janskies.

<!--Calculation Parameters-->
### Parameters File <a id="params"></a>

This table contains supplementary information related to the photometry calculations. This file is always named *parameters.fits*.

The following columns are included in the output:

- **Image (Filter):** the name of the filter.
- **Shift Correction Factor:** the x and y pixel shift applied to each galaxy before calculating the photometry, in order to correct for any uniform offsets between the image and the astrometry. This step is enabled with a flag and is defined as the average shift of all the sources from their best-fit flux centroids ([as determined by AstroPy][astropy-centroid-link]). When disabled, these values are zero.
- **Rescale Factor:** similarly to the Shift Correction Factor, this is the multiplicative x and y pixel rescaling applied to each galaxy to correct for any image scaling issues. This is also enabled with a flag and is defined as the average apparent scaling of all sources away from their best-fit flux centroids, **after correcting the uniform shift**. When disabled, these values are equal to one.
- **Rescale Origin:** the x and y pixel coordinates around which the apparent scaling is centred. When disabled, these values are zero.
- **Nominal Pixel Area:** the effective pixel area of the image, in units of steradian, extracted from the image header. Used to convert from flux density to flux.

<div align="right">

[[Back to Top](#contents)]

</div>

<!--HYPERLINKS-->
[astropy-error-link]: <https://photutils.readthedocs.io/en/stable/aperture.html#aperture-photometry-error-estimation> "Astropy Documentation on Aperture Photometry Error Estimation"
[astropy-centroid-link]: <https://photutils.readthedocs.io/en/stable/centroids.html> "AstroPy Documentation on Centroid Calculation"
