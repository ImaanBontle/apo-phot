# Apo Phot
This code takes NIRCam photometry images and performs apodised photometry (estimation of the flux through each NIRSpec aperture) on the given list of NIRSpec sources. It does this by overlaying the apertures on the sources, calculating the total flux through the aperture, and subtracting an estimated local background flux in the nearby sky region. It also provides an uncertainty estimate on the fluxes themselves.

## Required packages:
1. Astropy
2. Matplotlib
3. Numpy
4. Photutils
5. Tqdm (for the display of progress bars)
6. ipympl (if using jupyter-lab $\ge$ v3.0)

## Navigating this code

The code is broken up into three sections.
1. **Environment prep.**
   
   This section prepares the environment and loads all relevant objects.
   
2. **Generalised code.**
   
   This is a single set of functions that can be called with one command and will run the apodised photometry from start to finish.
   
3. **Demo calculations.**

   This section illustrates both the motivation and the implementation of each step in the process. This way you can familiarise yourself with the calculations as well as test your dataset for any errors.

## Things you will need to do before running the full code:

1. **Provide csv tables for each pointing** (called 'visits' in the code) **and for the target acquisition.**

   The code assumes the names of the visits have a similar format, with a unique identifier in the name for each visit. These identifiers should be listed in environment prep. Also, the target acquisition table is assumed to have a unique name (with 'TA' somewhere in it) and should be specified there too.
   
   If needed, you can dump these files from the APT file using the <a href="https://www.stsci.edu/scientific-community/software/astronomers-proposal-tool-apt">APT software</a> using the following steps:
    1. Open the apt file.
    2. Go to the relevant visit on the left, within the relevant plan.
    3. Switch to the MSA Planning Tool on the topbar.
    4. Click the Plans tab in the central window.
    5. Highlight (click on) the science plan within the Plan Selection section (usually the third of three).
    6. Once highlighted, go to the menu bar and click File..., Export..., then choose 'MSA Target Info [.csv]')
   
   **Each table should contain:**
    - The source IDs and coordinates in RA, Dec.
    - The aperture angle
    - The offsets of the sources within the aperture (in decimal percentages).

2. **Provide a list of identifiers/names for each photometry band image.**
3. **Provide a list of IDs and radii for any sources to which you'd like to apply a unique annulus size**

   This is used to estimate the local background noise in the sky region surrounding the source - the code sigma-clips this estimate to prevent other sources from incorrectly contributing to the estimate, but sometimes you may wish to tweak the sky region manually for some sources and this can be achieved here).

It is also recommended that you **run the demo code at least once on a new dataset** before running the full code (always restart the kernel first to clear variables from the demo). There are a few reasons this is a good idea:
- You may wish to check all the calculations are working correctly for a new dataset.
- Some bands have a different pixel size to the default (F200W and upwards), and it's important to check that radii are being correctly adjusted for this (the radius factors for each image are listed below and can be tweaked).
- You may wish to compare the aperture positions against Aladin (can be done in the APT software too, just send each science visit separately to Aladin via the MSA Planning Tool Plans tab).
- Additionally, if you have not used this code before, the demo can be helpful for understanding how each step works, especially since you may need to adjust the code to your dataset.
