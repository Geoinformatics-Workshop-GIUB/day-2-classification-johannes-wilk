#Visualization of LS-8 Data -----------------------------------------------------

#Installing required packages, prerequisites, import
#Install.packages("raster")
library(raster)

#Working directory
setwd("C:/Users/Johannes/Documents/1. Dokumente/3. Studium/2. Uni Bonn/1. Module/D2 R Kurs")
#inserting Landsat image (it does not matter if cropped or original image)
img <- brick("LC08_Bonn.tif")
img

#Plot
plotRGB(img,
        r = 3, g = 3, b = 3,
        stretch = "lin"
)

plotRGB(img,
        r = 4, g = 3, b = 2,
        stretch = "lin",
        )

#Save subset (nur wenn man das Bild vorher in R gecroppt hat)
#img.subset_vis <- crop(img, extent(362699.321, 369890.701, 5619755.014, 5624836.560))

#writeRaster(img.subset_vis,
#            filename = "C081960252020091901RT-SC20200925100850_subset_vis.tif",
#            format = "GTiff",
#            overwrite = TRUE
#)
img.subset_vis <- brick("LC08_Bonn.tif")
#Plot histogram/distribution
green <- img.subset_vis[[3]]
red <- img.subset_vis[[4]]
NIR <- img.subset_vis[[5]]
hist(green,
     breaks = 200,
     xlim = c(0, 2000),
     ylim = c(0, 20000),
     xlab = "band 3 reflectance value [DN * 0.01]",
     ylab = "frequency",
     main = "histogram L8 band 3 (green)"
)

