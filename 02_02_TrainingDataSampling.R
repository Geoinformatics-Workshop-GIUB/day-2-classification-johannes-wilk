#Classification: Preparing Samples ----------------------------------------------


#Installing required packages, prerequisites, import
#Install.packages("raster")
library(raster)

#Working directory
setwd("C:/Users/Johannes/Documents/1. Dokumente/3. Studium/2. Uni Bonn/1. Module/D2 R Kurs")

getwd()

dir()

#Import LS8 subset
img <- brick("LC08_Bonn1.tif")
img

#Import shapefile containing training data
shp <- shapefile("training_data2.shp")
shp

#crs(shp) <- "+proj=utm +zone=32 +datum=WGS84 +units=m +no_defs"

#Check CRS
compareCRS(img,shp)

#Plot data
plotRGB(img, r = 4, g = 3, b = 2, stretch = "lin")
plot(shp, col="red", add=TRUE)

#Conversion of class-characters
levels(as.factor(shp$class))

for (i in 1:length(unique(shp$class))) {cat(paste0(i, " ", levels(as.factor(shp$class))[i]), sep="\n")}

#Rename bands of LS image
names(img)
names(img) <- c("b1", "b2", "b3", "b4", "b5", "b6", "b7")
names(img)

#Create dataframe
smp <- extract(img, shp, df = TRUE)


#Matching ID of smp and class of shp to new column "cl", delete "ID"-column
smp$cl <- as.factor(shp$Class[match(smp$ID, seq(nrow(shp)))])
smp <- smp[-1]

#Save dataframe to your wd
save(smp, file = "smp.rda")
remove(smp)

#Load dataframe from your wd
load(file = "smp.rda")

#Check out the summary of the class-column smp
summary(smp$cl)

#Aggregate cl-column 
sp <- aggregate( . ~ cl, data = smp, FUN = mean, na.rm = TRUE )

#Plot empty plot of a defined size
plot(0,
     ylim = c(min(sp[2:ncol(sp)]), max(sp[2:ncol(sp)])), 
     xlim = c(1, ncol(smp)-1), 
     type = 'n', 
     xlab = "L8 bands", 
     ylab = "reflectance [% * 100]"
)

#Define colors for class representation - one color per class necessary!
mycolors <- c("#fbf793", "#006601", "#bfe578", "#d00000", "#6569ff")

#Draw one line for each class
for (i in 1:nrow(sp)){
  lines(as.numeric(sp[i, -1]), 
        lwd = 4, 
        col = mycolors[i]
  )
}

#Add a grid
grid()

#Add a legend
legend(as.character(sp$cl),
       x = "topleft",
       col = mycolors,
       lwd = 5,
       bty = "n"
)

