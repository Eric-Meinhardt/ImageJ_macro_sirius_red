/*
 * Title: Sirius red analysis in two channels
 * Author: Eric Meinhardt
 * Date: 2024-03-07
 * License: MIT
 * GitHub: https://github.com/Eric-Meinhardt/ImageJ_macro_sirius_red
 */

#@ File (label = "Input directory", style = "directory") input
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".tif") suffix

processFolder(input);

function processFolder(input) {
    list = getFileList(input);
    list = Array.sort(list);
    for (var i = 0; i < list.length; i++) {
        itemPath = input + File.separator + list[i];
        if (File.isDirectory(itemPath)) {
            processFolder(itemPath);
        }
        if (endsWith(list[i], suffix)) {
            processFile(input, output, list[i]);
        }
    }
}

function processFile(input, output, file) {
    setBatchMode(true);
    
    // 1. File validation
    fullPath = input + File.separator + file;
    if (!File.exists(fullPath)) {
        print("Skipping missing file:", fullPath);
        return;
    }
    
    // 2. Open image
    open(fullPath);
    if (nImages == 0) {
        print("Failed to open:", file);
        return;
    }
    originalID = getTitle();
    
    // 3. Process stack
    fileNoExtension = File.nameWithoutExtension;
    run("Duplicate...", "duplicate title=" + fileNoExtension);
    run("Stack to Images");
    
    // 4. Channel validation
    if (nImages < 2) {
        print("Insufficient channels in:", file);
        closeAll();
        return;
    }
    
   // 5. Measurement pipeline
    run("Set Measurements...", "area area_fraction limit display redirect=None decimal=3");
    selectWindow(fileNoExtension + "-0001");
    green = getTitle();
    selectWindow(fileNoExtension + "-0002");
    red1 = getTitle();
    
    imageCalculator("Add create", red1, green);
    setAutoThreshold("Default dark");
    run("Measure");
    close();
    
    selectWindow(red1);
    run("Subtract Background...", "rolling=50");
    redBackground = getTitle();
    imageCalculator("Subtract create", redBackground, green);
    
    selectWindow("Result of " + red1);
    setAutoThreshold("Huang dark");
    run("Measure");
    run("Close All");
    }
    
    // 6. Save results
    selectWindow("Results");
    saveAs("text", output + File.separator + "Results");
    run("Close");
