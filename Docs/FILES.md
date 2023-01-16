<!--Table of Contents-->
# Apodised Photometry <a id="contents"></a>

The output folders contain several FITS tables with information on the apodised photometry for each NIRCam filter. This README explains how the output files are structured.

First, an [overview](#overview) of the files is provided. This is then followed by a [detailed breakdown](#files) of the values in each table. In most cases, readers should focus on the [summary files for each filter](#results) (these files contain the average apodised fluxes for each galaxy while the remaining files are supplementary).

Use the following table to jump to the relevant section.

- [Overview](#overview)
- [Files](#files)
	- [Results](#results)
	- [Details](#details)
	- [Parameters](#params)

<!--Overview of the Files-->
## Overview of Output Files <a id="overview"></a>

*This section provides an overview of the output files.*

For each source appearing in a filter, the apodised photometry (the total galaxy flux passing through the MSA slit) was calculated and averaged across the available observations, to produce an averaged apodised flux for that photometry band. This process was repeated for each dataset and the results stored in a dedicated folder (e.g. *SMACS-ERC* or *HST-Deep*).

There are three types of FITS tables in each folder:

1. [A summary file for each filter](#results) (e.g. *F400W_summary.fits*) - This contains the apodised fluxes averaged across all the available observations for a given filter. ***This is the most useful file for most readers.***
2. [A detailed results breakdown for each observation](#details) (e.g. *F400W_8.fits*) - These provide more detailed information on each observation for a given filter. Most of this isn't relevant, but some of it may be useful if following up on a particular observation.
3. [A separate parameters file](#params) (i.e. *parameters.fits*) - Extra, supplementary information regarding the flux calculations. This is mostly relevant for debugging purposes, but contains values such as the flux conversion factors and the rescaling parameters used for each filter.

<div align="right">

[[Back to Top](#contents)]

</div>

<!--Detailed File Breakdowns-->
## File Types <a id="files"></a>

*This section contains a detailed breakdown of each FITS table.*

<!--Results per Filter-->
### Results Files <a id="results"></a>

These tables contain the most relevant results for each of the galaxies in a filter. The following naming convention is used: *\<filter-name\>_summary.fits*, where *filter-name* refers to the relevant photometric filter (e.g. *F200W*).

Fluxes are provided in raw counts and in micro-Jy. For details regarding the error estimations, see the [AstroPy Documentation][astropy-error-link].

Each table contains the following columns:

- **ID:** the ID of the galaxy.
- **RA:** the right ascension of the galaxy in degrees.
- **Dec:** the declination of the galaxy in degrees.
- **Total Counts:** the total flux passing through the aperture, in units of counts.
- **Background Counts/Pixel:** an estimate of the background in the region surrounding the galaxy, in units of counts per arcsecond squared.
- **Actual Counts:** the background-subtracted flux passing through the aperture, in units of counts.
- **Counts Error:** an estimate of the error in the actual counts, in units of counts.
- **Total Flux:** the total flux passing through the aperture, in units of micro-Jy.
- **Background Flux/Pixel:** an estimate of the background in the region surrounding the galaxy, in units of micro-Jy per arcsecond squared.
- **Actual Flux:** the background-subtracted flux passing through the aperture, in units of micro-Jy.
- **Flux Error:** an estimate of the error in the actual flux, in units of micro-Jy.

<!--Results per Observation-->
### Detailed Output Files <a id="details"></a>

These tables contain detailed results for every available observation for each filter. The following naming convention is used: *\<filter-name\>_\<visit-name\>*, where *filter-name* refers to the relevant photometric filter (e.g.*F200W*) and *visit-name* refers to the internal name used to refer to the observation (e.g. *12* or *c1-2e2n3-G395M-F290LP*.

Offsets are provided as decimal percentages. Coordinates and areas are provided in pixels. Fluxes are provided in raw counts and in micro-Jy. For details regarding the error estimations, see the [AstroPy Documentation][astropy-error-link].

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
- **Total Counts:** the total flux passing through the aperture, in units of counts.
- **Background Counts/Pixel:** an estimate of the background in the region surrounding the galaxy, in units of counts per arcsecond squared.
- **Actual Counts:** the background-subtracted flux passing through the aperture, in units of counts.
- **Counts Error:** an estimate of the error in the actual counts, in units of counts.
- **Total Flux:** the total flux passing through the aperture, in units of micro-Jy.
- **Background Flux/Pixel:** an estimate of the background in the region surrounding the galaxy, in units of micro-Jy per arcsecond squared.
- **Actual Flux:** the background-subtracted flux passing through the aperture, in units of micro-Jy.
- **Flux Error:** an estimate of the error in the actual flux, in units of micro-Jy.

<!--Calculation Parameters-->
### Parameters File <a id="params"></a>

This table contains supplementary information related to the photometry calculations. This file is always named *parameters.fits*.

The following columns are included in the output:
- **Image (Filter):** the name of the filter.
- **Shift Correction Factor:** the x and y pixel shift applied to each galaxy before calculating the photometry, in order to correct for any uniform offsets between the image and the astrometry. This step is enabled with a flag and is defined as the average shift of all the sources from their best-fit flux centroids ([as determined by AstroPy][astropy-centroid-link]). When disabled, these values are both zero.
- **Rescale Factor:** similarly to the Shift Correction Factor, this is the multiplicative x and y pixel rescaling applied to each galaxy to correct for any slight image scaling issues. This is also enabled with a flag and is defined as the average apparent scaling of all sources away from their best-fit flux centroids, **after correcting the uniform shift**. When disabled, these values are both one.
- **Rescale Origin:** the x and y pixel coordinates around which the apparent scaling is centred. When disabled, these values are zero.
- **Nominal Pixel Area:** the effective pixel area of the image, in units of arcseconds squared, extracted from the image header. Used to convert from counts to flux.
- **Flux Conversion Factor:** the average flux per square pixel for the image, in units of micro-Jansky per arcsecond squared, extracted from the image header. Used to convert from counts to flux.

<div align="right">

[[Back to Top](#contents)]

</div>

<!--HYPERLINKS-->
[astropy-error-link]: <https://photutils.readthedocs.io/en/stable/aperture.html#aperture-photometry-error-estimation> "Astropy Documentation on Aperture Photometry Error Estimation"
[astropy-centroid-link]: <https://photutils.readthedocs.io/en/stable/centroids.html> "AstroPy Documentation on Centroid Calculation"
