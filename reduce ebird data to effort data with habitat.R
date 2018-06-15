##Reorganize eBird data to isolate effort data 
# This R-code is written by Ancilleno Davis in partial completion of the requirements
# for the PhD in Ecology, Evolution and Environmental Biology
# at Miami University in Oxford, Ohio.
# 
# The purpose of this code is to import a csv file downloaded from www.eBird.org
# convert it to a data frame with only the columns that indicate observer effort and species:
# Location, date, time, observer identity and a unique identifier for the survey
#extract habitat information at survey locations 
#and append the habitat information to the data frame
#finally reduce that dataframe to a dataframe that includes only effort data.


#### Initial workspace parameters####
#set seed
set.seed(1981)

#Set my working directory and load necessary libraries
setwd("C:/Users/davisao2/Desktop/open source GIS/eBird r code")
#note this working directory should include:
#1: the geotiff of the raster data created using the Google Earth Engine habitat classification
#2: a spreadsheet of the eBird observations from the region of interest in a comma separated values text file.

#importing raster data
require(caret)#this has confusionMatrix for determining raster accuracy
require(cooccur)
require(data.table)#to allow rearrangment of columns by their headings
require(EcoSimR)
require("FactoMineR")#used for the Multiple Correspondence Analysis of the raster datasets
require("factoextra")#used for the Multiple Correspondence Analysis of the raster datasets
require(fmsb)
require(geosphere)
require(ggplot2)
require(ggpubr)
require(gstat)
require(lme4)
require(lmerTest)
require(plyr)
require(psych)
require(raster)
require(readr)
require(readxl)
require(reshape2)#contains dcast for reorganizing data into presence absence etc.
require(rgdal)#read in shapefiles
require(rgeos)
require(RStoolbox)
require(sp)

dev.off()#this resets the graphics window so that margins and other adjustments are returned to default

getmode <- function(v) { #creating this mode function allows me to get the most common value
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}


#Assign the colors I would like to represent my habitat classes####


col7class=c(#include all 7 colors including water. This will be used to plot the raster image.
  "blue", #ocean 
  "dark green", #Pine Forest
  "brown", #Wetlands 
  "seashell2",#sand
  "gray", #Urban
  "Light green", #grass
  "yellow")#high water table plant communities
##Assign label names for the habitat classes####
legend=c("Water", 
         "Pine", 
         "Wetland", 
         "Sand", 
         "Urban", 
         "Grass", 
         "HWTC")
#import the Outline of Grand Bahama Island and reproject to WGS84####
GBOutline<-readOGR(".","Grand_Bahama_Outline")
print(proj4string(GBOutline)) #details of the projection for GBOutline
plot(GBOutline, 
     axes=T, #remove the lat long coordinates with F and add them with T
     border="black")

#Reproject GBOutline to WGS84
GBOutlineWGS84 <- 
  spTransform(GBOutline, #this command reprojects a spatial item  
              CRS("+proj=longlat +datum=WGS84"))#the new projection is WGS 84

plot(GBOutlineWGS84, 
     axes=TRUE, 
     border="black",
     las=1,
     #ylab="Latitude",
     # xlab="Longitude",
     main="Grand Bahama Contiguous Area WGS84")
###Import Rasters of habitat classification ####

#Random Forests classification map created using
#6 Landsat 8 OLI bands 2,3,4,5,6,7
#collected during 2017-01-01 through 2017-12-31

RF7Classes2017<-raster("RFclass6bands30m7classes2017.tif")
RF7Classes2017@crs #finds the coordinate reference system which is already WGS84
RF7Classes2017@extent #gives me the boundaries of the raster

plot(RF7Classes2017, 
     las=1, #rotates the y-axis labels horizontal
     ylab="Latitude",
     xlab="Longitude",
     main = "Grand Bahama Habitat Map")
#overlay the reprojected shapefile on the raster####
plot(GBOutlineWGS84, add=T)
#contiguous area habitat

#Clip area to the contiguous area of Grand Bahama Island####
GBcontiguoushab<-#this vector will hold our clipped raster
  mask(RF7Classes2017#This is the raster image to be clipped
       , GBOutlineWGS84)#This is the shape you are clipping to

plot(GBcontiguoushab); plot(GBOutlineWGS84, add=T) #Plot the trimmed raster and the outline
summary(GBcontiguoushab) #note all the clipped area is now NA
##Save the newly clipped raster to a file you can use in other software####
writeRaster(GBcontiguoushab,#our new rater image
            "GBcontiguoushab.tif"#the file name we want to save it to
            , format="GTiff") #the raster format we are using.
##display the clipped raster####
GBcontiguoushab.range<-cellStats(GBcontiguoushab, range)

plot(GBcontiguoushab,#plot this raster file
     col=col7class, #a list of colors make sure they are in the order of the classes you are plotting
     axis.args=list(
       at= #how do you want the axis labels spread out?
         seq(#sequential separations from the 
           GBcontiguoushab.range[1],#lowest end of the range
           GBcontiguoushab.range[2], #to the highest end of the range
           1),#with one unit of separation between each tick mark
       labels=legend, #at each tick mark, what do you want the label to say?
       cex.axis=1),
     axes=T ,
     main = "Grand Bahama Island, Bahamas habitat map", #title of the plot 
     ylab="Latitude", #left side 
     xlab="Longitude", #x axis label
     las=1 #rotate the y axis labels to horizontal
)
plot(GBOutlineWGS84, add=T)
legend('bottomright', legend , fill=col7class, border="black",
       col=col7class, bty='n', cex=1.5)
#summarize the number of pixels and the geographic area in each class####
GBhabitatdf<-as.data.frame(GBcontiguoushab)
pixels<-count(GBhabitatdf, "RFclass6bands30m7classes2017")
habitatpixels<-pixels$freq[1:7]
habitatareakm2<- #a vector of the total area in each habitat type
  (pixels$freq[1:7] #1:7 selects the columns with the classes 0-6 and ignores the NA values
  )*0.0009 #0.0009 is the number of km2 in a 30 x 30 m pixel (Landsat 8 imagery)
habitatareakm2
totalpixels<- #vector for the total pixels in the study area
  sum(habitatpixels$freq[1:7])
totalarea<-#vector of total area in study area
  sum(habitatareakm2)
percentarea<-habitatareakm2/totalarea #%of total area in each habitat type

habitat<-data.frame(legend,habitatpixels$freq[1:7],habitatareakm2,percentarea)

##Display barplots of the pixel area in each habitat type.####
BpGBHabitatPixels<-barplot(habitatpixels, 
                           col=col7class,
                           axes=F,
                           main="Pixels per terrestrial habitat class on Grand Bahama, 2017", 
                           xlab="Habitat type",
                           ylab="Number of Pixels",
                           horiz=FALSE,
                           ylim=c(0,400000),
                           names.arg=c("Water", 
                                       "Pine", 
                                       "Wetland", 
                                       "Sand", 
                                       "Urban", 
                                       "Grass", 
                                       "HWTC"),
                           las=1)
text(BpGBHabitatPixels, 
     habitatpixels, 
     label=habitatpixels, 
     pos = 3, 
     xpd = NA)
##Display barplots of the km2 area in each habitat type.####

BpGBHabitatkm2<-barplot(habitatareakm2, 
                        col=col7class,
                        axes=F,
                        main="Square Km per terrestrial habitat class on Grand Bahama, 2017", 
                        xlab="Habitat type",
                        ylab="Area (sq.Km)",
                        horiz=FALSE,
                        ylim=c(0,400),
                        names.arg=c("Water", 
                                    "Pine", 
                                    "Wetland", 
                                    "Sand", 
                                    "Urban", 
                                    "Grass", 
                                    "HWTC"))
text(BpGBHabitatkm2, 
     habitatareakm2, 
     label=habitatareakm2, 
     pos = 3, 
     xpd = NA)



###Import confusion matrix generate in Google Earth Engine Code API and calculate Cohen's Kappa####
#Import the confusion matrix that was calculated by Google Earth Engine 
#your confusionmatrix should be in a csv with no header rows
#using validation data
confmatrix20177classes <-read_csv("7x7 class confusion matrix 2017.csv", 
                                  col_names = TRUE)
##View(confmatrix20177classes)
confmatrix20177classes<-as.data.frame(confmatrix20177classes)
rownames(confmatrix20177classes)<-
  colnames(confmatrix20177classes)<-
  c("Water",
    "Pine",
    "Wetland",
    "Sand",
    "Urban",
    "Grass",
    "HWTC")

#calculate the cohen's kappa coefficient to determine the agreement between 
#the classification and validation data
Kappa.test(confmatrix20177classes,y=NULL, conf.level=0.95)




# ###Import the data table including the eBird locations and visual classification of the site by Ancilleno Davis####
# VisualClassification <-read_csv("Visual Classification of eBird sites on Grand Bahama.csv", 
#                                   col_names = TRUE)
# VisualClassificationcoords<-data.frame(VisualClassification$LONGITUDE,VisualClassification$LATITUDE)
# ##Extract the habitat data from the raster and add it to the visual classification data frame
# VisualClassification$Habitat<-
#   extract(RF7Classes2017,
#           VisualClassificationcoords)
# VisualVsGEEHabitat<-data.frame(as.factor(VisualClassification$Habitat),as.factor(VisualClassification$`Visual verification`))
# colnames(VisualVsGEEHabitat)<-c("raster","visual")
# 
# summary(VisualVsGEEHabitat)
# 
# merge.test <- merge(GBeBird1988.2016, VisualClassification, by=c('LATITUDE', 'LONGITUDE'),all=TRUE)[,-1]
# #Calculate Cohen's Kappa on the generated raster and visual verification of habitat at eBird Localities
# cohen.kappa(VisualVsGEEHabitat)





####create data frame with all bird observation data for Grand Bahama####

BSeBirdNOV2017complete <- read_csv("ebd_BS_relNov-2017.csv", 
                                   col_types = cols(
                                     `ALL SPECIES REPORTED` = col_factor(levels = c("0","1")), 
                                     APPROVED = col_factor(levels = c("0","1")), 
                                     `EFFORT AREA HA` = col_double(), 
                                     `HAS MEDIA` = col_factor(levels = c("0","1")), 
                                     `OBSERVATION COUNT` = col_integer(), 
                                     `OBSERVATION DATE` = col_date(format = "%m/%d/%Y"), 
                                     REVIEWED = col_factor(levels = c("0","1")), 
                                     `TIME OBSERVATIONS STARTED` = col_time(format = "%H:%M:%S")))

#subset to data around Grand Bahama Island####
GBeBirdcomplete<-BSeBirdNOV2017complete[ #subset
  BSeBirdNOV2017complete$STATE_PROVINCE %in% 
    c('Freeport and West Grand Bahama', 'East Grand Bahama'),]
#Replace all NAs in the Observation Count column with 1####
#The species was identified but there was no count of individuals at least one individual is assumed

GBeBirdcomplete$`OBSERVATION COUNT`[is.na(GBeBirdcomplete$`OBSERVATION COUNT`)]<-1

#add columns for the month, year and day of the week of the observations####
GBeBirdcomplete$YEAR<-as.numeric(format(GBeBirdcomplete$`OBSERVATION DATE`, format = "%Y"))
GBeBirdcomplete$MONTH<-as.numeric(format(GBeBirdcomplete$`OBSERVATION DATE`, format = "%m"))
GBeBirdcomplete$day <- as.factor(weekdays(as.Date(GBeBirdcomplete$`OBSERVATION DATE`)))
GBeBirdcomplete$day  <- factor(GBeBirdcomplete$day, levels= c("Sunday", "Monday", 
                                                              "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

GBeBirdcomplete[order(GBeBirdcomplete$day), ]
#View(GBeBirdcomplete)



# select date range ------------------------------------------------------------
GBeBirdDEC2016<-GBeBirdcomplete[ #subset
  (GBeBirdcomplete$`OBSERVATION DATE`> "1987-12-31" & 
     GBeBirdcomplete$`OBSERVATION DATE` < "2017-01-01"),] #Before this date2017


#Create yearly subset 2016 only ####
GBeBird2016only<-GBeBirdcomplete[ #subset
  (GBeBirdcomplete$`OBSERVATION DATE`> "2015-12-31" & #After this date
     GBeBirdcomplete$`OBSERVATION DATE` < "2017-01-01"),] #Before this date2017



# select only surveys in which all species were recorded ---------------------------------------------
GBeBirdDEC2016<-GBeBirdDEC2016[ #subset
  GBeBirdDEC2016$`ALL SPECIES REPORTED`== "1",] #records with all species reported


###The GBeBirdDEC2016 now includes all ebird data up to December 31 2016 and since 1988#### 

##in which observers attempted to record all the species they were able to identify.####
#View(GBeBirdDEC2016)
##remove unneeded columns####
GBeBirdDEC2016$`LAST EDITED DATE`<-
  GBeBirdDEC2016$`SUBSPECIES COMMON NAME`<-
  GBeBirdDEC2016$`SUBSPECIES SCIENTIFIC NAME`<-
  GBeBirdDEC2016$`BREEDING BIRD ATLAS CODE`<-
  GBeBirdDEC2016$`BREEDING BIRD ATLAS CATEGORY`<-
  GBeBirdDEC2016$`AGE/SEX`<-
  GBeBirdDEC2016$COUNTRY<-
  GBeBirdDEC2016$COUNTRY_CODE<-
  GBeBirdDEC2016$COUNTY<-
  GBeBirdDEC2016$SUBNATIONAL1_CODE<-
  GBeBirdDEC2016$SUBNATIONAL2_CODE<-
  GBeBirdDEC2016$`IBA CODE`<-
  GBeBirdDEC2016$`BCR CODE`<-
  GBeBirdDEC2016$`USFWS CODE`<-
  GBeBirdDEC2016$`ATLAS BLOCK`<-
  NULL
#View the resulting data frame####
View(GBeBirdDEC2016)
####Compile BAH and DAS species lists####
#Compile list of Bahamian endemic and resident species of importance for comparison###
BAHspecieslist<-c("Bahama Mockingbird", 
                  "Bahama Swallow", 
                  "Bahama Warbler", 
                  "Bahama Woodstar", 
                  "Bahama Yellowthroat",
                  "Brown-headed Nuthatch",
                  "Common Ground-Dove", 
                  "Cuban Pewee",
                  "Hairy Woodpecker",
                  "La Sagra's Flycatcher",
                  "Loggerhead Kingbird",
                  "Northern Mockingbird", 
                  "Olive-capped Warbler",
                  "Pine Warbler",
                  "Red-legged Thrush",
                  "Western Spindalis")

#Compile list of Detroit Audubon society Species of concern
DASspecieslist<-c("American Kestrel",
                  "Barn Swallow",
                  "Belted Kingfisher",
                  "Blue-winged Teal",
                  "Canvasback",##Note there are no canvasback in the data set
                  "Common Tern",
                  "Gray Catbird",
                  "Great Blue Heron",
                  "Indigo Bunting",
                  "Killdeer",
                  "Kirtland's Warbler",##no Kirtland's Warblers were found on GB
                  "Lesser Scaup",
                  "Osprey",
                  "Palm Warbler",
                  "Piping Plover",
                  "Ring-necked Duck",
                  "Ruddy Turnstone",
                  "Sanderling",
                  "Sharp-shinned Hawk",
                  "Turkey Vulture"
)

#NB these lists are not comprehensive

###insert columns to classify all bird species as a Bahamian or DAS species ####
#based on being in BAHspecieslist or DASspecieslist 

GBeBirdDEC2016$BAHspecies<-GBeBirdDEC2016$`COMMON NAME`%in% BAHspecieslist
GBeBirdDEC2016$DASspecies<-GBeBirdDEC2016$`COMMON NAME`%in% DASspecieslist


####create location dataframes for all observations and BAH or DAS species observations.####
GBeBirdDEC2016Localities<-
  data.frame(GBeBirdDEC2016$LOCALITY, 
             GBeBirdDEC2016$`LOCALITY ID`,
             GBeBirdDEC2016$LONGITUDE,
             GBeBirdDEC2016$LATITUDE)


#Get location coordinates for All species and BAH or DAS species####  
GBeBirdDEC2016coords<-
  data.frame(GBeBirdDEC2016$LONGITUDE,
             GBeBirdDEC2016$LATITUDE)


#extract habitat from the raster at the points in the location dataframes####
#add habitat to a new column in the eBird data
GBeBirdDEC2016$Habitat<-
  raster::extract(RF7Classes2017,
                  GBeBirdDEC2016coords)


##Export data with habitat type to csv files####
write.csv(GBeBirdDEC2016, "GBeBirdDEC2016ALLhabitat.csv")#all the ebird data plus habitat data for All species

#Create a dataframe of only the effort and habitat data####

GBebirdeffort2016<-data.frame(GBeBirdDEC2016$Habitat,
                              GBeBirdDEC2016$`LOCALITY ID`,
                              GBeBirdDEC2016$LATITUDE,
                              GBeBirdDEC2016$LONGITUDE,
                              GBeBirdDEC2016$`OBSERVER ID`,
                              GBeBirdDEC2016$`SAMPLING EVENT IDENTIFIER`,
                              GBeBirdDEC2016$YEAR,
                              #GBeBirdDEC2016$`COMMON NAME`,
                              GBeBirdDEC2016$MONTH,
                              GBeBirdDEC2016$`OBSERVATION DATE`,
                              GBeBirdDEC2016$`TIME OBSERVATIONS STARTED`,
                              GBeBirdDEC2016$`DURATION MINUTES`)
colnames(GBebirdeffort2016)<-c("Habitat", 
                               "Locality",
                               "Latitude",
                               "Longitude",
                               "Observer", 
                               "Survey", 
                               "Year",
                               #"Species",
                               "Month", 
                               "Date", 
                               "Time", 
                               "Duration")


GBebirdeffortandSPS2016<-data.frame(GBeBirdDEC2016$Habitat,
                              GBeBirdDEC2016$`LOCALITY ID`,
                              GBeBirdDEC2016$LATITUDE,
                              GBeBirdDEC2016$LONGITUDE,
                              GBeBirdDEC2016$`OBSERVER ID`,
                              GBeBirdDEC2016$`SAMPLING EVENT IDENTIFIER`,
                              GBeBirdDEC2016$YEAR,
                              GBeBirdDEC2016$`COMMON NAME`,
                              GBeBirdDEC2016$MONTH,
                              GBeBirdDEC2016$`OBSERVATION DATE`,
                              GBeBirdDEC2016$`TIME OBSERVATIONS STARTED`,
                              GBeBirdDEC2016$`DURATION MINUTES`)
colnames(GBebirdeffortandSPS2016)<-c("Habitat", 
                               "Locality",
                               "Latitude",
                               "Longitude",
                               "Observer", 
                               "Survey", 
                               "Year",
                               "Species",
                               "Month", 
                               "Date", 
                               "Time", 
                               "Duration")
GBebirdeffort2016$Habitat<-as.factor(GBebirdeffort2016$Habitat)
GBebirdeffort2016$Habitat<-
  revalue(GBebirdeffort2016$Habitat, 
          c("0"="Water", 
            "1"="Pine", 
            "2"="Wetland", 
            "3"= "Sand", 
            "4"= "Urban", 
            "5"="Grass", 
            "6" = "HWTC"))

GBebirdeffortandSPS2016$Habitat<-as.factor(GBebirdeffortandSPS2016$Habitat)
GBebirdeffortandSPS2016$Habitat<-
  revalue(GBebirdeffortandSPS2016$Habitat, 
          c("0"="Water", 
            "1"="Pine", 
            "2"="Wetland", 
            "3"= "Sand", 
            "4"= "Urban", 
            "5"="Grass", 
            "6" = "HWTC"))


#Only surveys with complete data####
GBebirdeffort2016<- GBebirdeffort2016[complete.cases(GBebirdeffort2016),] #No NA's in any columns
GBebirdeffort2016<-unique(GBebirdeffort2016)# Only unique entries, no double counting of surveys

GBebirdeffortandSPS2016<- GBebirdeffortandSPS2016[complete.cases(GBebirdeffortandSPS2016),] #No NA's in any columns
GBebirdeffortandSPS2016<-unique(GBebirdeffortandSPS2016)# Only unique entries, no double counting of surveys

