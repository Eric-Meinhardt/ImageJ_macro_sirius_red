# ImageJ_macro_sirius_red
This is an ImageJ Macro which can be used to quantify the fibrotic area in heart sections stained with Picrosirius red and visualized using standard fluorescence microscopy in two separate channels, ~488 nm (FITC, representing the background flourescence and used to quantify the total tissue area) and ~605 (TexasRed/Rhodamine, for collagen deposition), as proposed by Vogel et al. 2015 (doi: 10.1016/j.mex.2015.02.007). Note that this is in contrast to standard protocols for Picrosirius red, which are most often visualizing the fibrotic tissue with either polarized light or bright field. 

## Features
- Batch processing of TIFF stacks
- Background subtraction
- Threshold-based measurements

## Installation
1. Download [ImageJ_macro_sirius_red](Eric-Meinhardt/ImageJ_macro_sirius_red.ijm)
2. Open in ImageJ via `Plugins > Macros > Install...`

## Usage
After starting the macro, the user will be asked to provide a source directory as well as an output directory. The source directory contains .tif files with two fluorescence channels either merged or stacked. The output file will be a .txt file with two measurements for each image, which can be easily imported in Excel/R. the first area value denotes the total tissue area, the second the fibrotic area. Deviding fibrotic area by the total area will result in a measure of the fibrotic area percentage. Note that only .tif files will be recognized as source files. File names may not contain blanks, only underlines "_" are allowed

## Citation
If used in research, please cite:
Wingert J, Meinhardt E, Sasipong N, Pott M, Lederer C, de la Torre C, Sticht C, Most P, Katus HA, Frey N, Raake PWJ, Schlegel P. Cardiomyocyte-specific RXFP1 overexpression protects against pressure overload-induced cardiac dysfunction independently of relaxin. Biochem Pharmacol. 2024 Jul;225:116305. doi: 10.1016/j.bcp.2024.116305. Epub 2024 May 19. PMID: 38768763.
