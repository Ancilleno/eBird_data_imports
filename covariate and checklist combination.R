# eBird covariates import
# This import from the eBird Extended Covariates files includes:
#   the Sampling Event, Locality, UMD Land Cover Classification and Water Classification


# set working directory that contains the covariate csv for each y --------
setwd("C:/Users/davisao2/Desktop/open source GIS/eBird r code/eBird 2016/ERD2016SS/All years/Bahamas Covariates")
#The extended covariates files have been downloaded and unzipped into the working directory as csv files.


# Load the necessary libraries --------------------------------------------


library(readr)




# import data -------------------------------------------------------------

#import the checklist data for Grand Bahama
allGBChecklists1988_2016 <- read_csv("allGBChecklists1988-2016.csv")
View(allGBChecklists1988_2016)

#import the covariate data for each year
#NB eBird was created in 2002 so all years before that are combined into 2002
#extract only the Locality ID, Sampling Event ID, Landcover Classification, Watercover Classification, and Year

extended_covariates2002 <- read_csv("extended-covariates2002.csv",
                                    col_types = cols_only(LOC_ID = col_character(),
                      SAMPLING_EVENT_ID = col_character(),
                      UMD_LANDCOVER = col_factor(
                        levels = c("0","1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13")),
                      UMD_WATERCOVER = col_character(),
                      YEAR = col_integer()))



extended_covariates2003 <- read_csv("extended-covariates2003.csv",
                                    col_types = cols_only(LOC_ID = col_character(),
                                                          SAMPLING_EVENT_ID = col_character(),
                                                          UMD_LANDCOVER = col_factor(
                                                            levels = c("0","1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13")),
                                                          UMD_WATERCOVER = col_character(),
                                                          YEAR = col_integer()))

extended_covariates2004 <- read_csv("extended-covariates2004.csv",
                                    col_types = cols_only(LOC_ID = col_character(),
                                                          SAMPLING_EVENT_ID = col_character(),
                                                          UMD_LANDCOVER = col_factor(
                                                            levels = c("0","1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13")),
                                                          UMD_WATERCOVER = col_character(),
                                                          YEAR = col_integer()))


extended_covariates2005 <- read_csv("extended-covariates2005.csv",
                                    col_types = cols_only(LOC_ID = col_character(),
                                                          SAMPLING_EVENT_ID = col_character(),
                                                          UMD_LANDCOVER = col_factor(
                                                            levels = c("0","1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13")),
                                                          UMD_WATERCOVER = col_character(),
                                                          YEAR = col_integer()))


extended_covariates2006 <- read_csv("extended-covariates2006.csv",
                                    col_types = cols_only(LOC_ID = col_character(),
                                                          SAMPLING_EVENT_ID = col_character(),
                                                          UMD_LANDCOVER = col_factor(
                                                            levels = c("0","1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13")),
                                                          UMD_WATERCOVER = col_character(),
                                                          YEAR = col_integer()))


extended_covariates2007 <- read_csv("extended-covariates2007.csv",
                                    col_types = cols_only(LOC_ID = col_character(),
                                                          SAMPLING_EVENT_ID = col_character(),
                                                          UMD_LANDCOVER = col_factor(
                                                            levels = c("0","1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13")),
                                                          UMD_WATERCOVER = col_character(),
                                                          YEAR = col_integer()))


extended_covariates2008 <- read_csv("extended-covariates2008.csv",
                                    col_types = cols_only(LOC_ID = col_character(),
                                                          SAMPLING_EVENT_ID = col_character(),
                                                          UMD_LANDCOVER = col_factor(
                                                            levels = c("0","1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13")),
                                                          UMD_WATERCOVER = col_character(),
                                                          YEAR = col_integer()))


extended_covariates2009 <- read_csv("extended-covariates2009.csv",
                                    col_types = cols_only(LOC_ID = col_character(),
                                                          SAMPLING_EVENT_ID = col_character(),
                                                          UMD_LANDCOVER = col_factor(
                                                            levels = c("0","1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13")),
                                                          UMD_WATERCOVER = col_character(),
                                                          YEAR = col_integer()))


extended_covariates2010 <- read_csv("extended-covariates2010.csv",
                                    col_types = cols_only(LOC_ID = col_character(),
                                                          SAMPLING_EVENT_ID = col_character(),
                                                          UMD_LANDCOVER = col_factor(
                                                            levels = c("0","1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13")),
                                                          UMD_WATERCOVER = col_character(),
                                                          YEAR = col_integer()))


extended_covariates2011 <- read_csv("extended-covariates2011.csv",
                                    col_types = cols_only(LOC_ID = col_character(),
                                                          SAMPLING_EVENT_ID = col_character(),
                                                          UMD_LANDCOVER = col_factor(
                                                            levels = c("0","1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13")),
                                                          UMD_WATERCOVER = col_character(),
                                                          YEAR = col_integer()))


extended_covariates2012 <- read_csv("extended-covariates2012.csv",
                                    col_types = cols_only(LOC_ID = col_character(),
                                                          SAMPLING_EVENT_ID = col_character(),
                                                          UMD_LANDCOVER = col_factor(
                                                            levels = c("0","1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13")),
                                                          UMD_WATERCOVER = col_character(),
                                                          YEAR = col_integer()))


extended_covariates2013 <- read_csv("extended-covariates2013.csv",
                                    col_types = cols_only(LOC_ID = col_character(),
                                                          SAMPLING_EVENT_ID = col_character(),
                                                          UMD_LANDCOVER = col_factor(
                                                            levels = c("0","1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13")),
                                                          UMD_WATERCOVER = col_character(),
                                                          YEAR = col_integer()))


extended_covariates2014 <- read_csv("extended-covariates2014.csv",
                                    col_types = cols_only(LOC_ID = col_character(),
                                                          SAMPLING_EVENT_ID = col_character(),
                                                          UMD_LANDCOVER = col_factor(
                                                            levels = c("0","1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13")),
                                                          UMD_WATERCOVER = col_character(),
                                                          YEAR = col_integer()))


extended_covariates2015 <- read_csv("extended-covariates2015.csv",
                                    col_types = cols_only(LOC_ID = col_character(),
                                                          SAMPLING_EVENT_ID = col_character(),
                                                          UMD_LANDCOVER = col_factor(
                                                            levels = c("0","1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13")),
                                                          UMD_WATERCOVER = col_character(),
                                                          YEAR = col_integer()))


extended_covariates2016 <- read_csv("extended-covariates2016.csv",
                                    col_types = cols_only(LOC_ID = col_character(),
                                                          SAMPLING_EVENT_ID = col_character(),
                                                          UMD_LANDCOVER = col_factor(
                                                            levels = c("0","1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13")),
                                                          UMD_WATERCOVER = col_character(),
                                                          YEAR = col_integer()))





# create list of surveys to filter covariates -----------------------------

#create a list of sampling events for Grand Bahama from 1988-2016
Survey<-unique(allGBChecklists1988_2016$`SAMPLING EVENT IDENTIFIER`)
Survey


# filter covariate data to the surveys on Grand Bahama from 1988-2 --------


#filter the covariate data to those surveys that occur in Grand Bahama 1988-2016

extended_covariates2002a<- extended_covariates2002[extended_covariates2002$SAMPLING_EVENT_ID %in% Survey,]
extended_covariates2003a<- extended_covariates2003[extended_covariates2003$SAMPLING_EVENT_ID %in% Survey,]
extended_covariates2004a<- extended_covariates2004[extended_covariates2004$SAMPLING_EVENT_ID %in% Survey,]
extended_covariates2005a<- extended_covariates2005[extended_covariates2005$SAMPLING_EVENT_ID %in% Survey,]
extended_covariates2006a<- extended_covariates2006[extended_covariates2006$SAMPLING_EVENT_ID %in% Survey,]
extended_covariates2007a<- extended_covariates2007[extended_covariates2007$SAMPLING_EVENT_ID %in% Survey,]
extended_covariates2008a<- extended_covariates2008[extended_covariates2008$SAMPLING_EVENT_ID %in% Survey,]
extended_covariates2009a<- extended_covariates2009[extended_covariates2009$SAMPLING_EVENT_ID %in% Survey,]
extended_covariates2010a<- extended_covariates2010[extended_covariates2010$SAMPLING_EVENT_ID %in% Survey,]
extended_covariates2011a<- extended_covariates2011[extended_covariates2011$SAMPLING_EVENT_ID %in% Survey,]
extended_covariates2012a<- extended_covariates2012[extended_covariates2012$SAMPLING_EVENT_ID %in% Survey,]
extended_covariates2013a<- extended_covariates2013[extended_covariates2013$SAMPLING_EVENT_ID %in% Survey,]
extended_covariates2014a<- extended_covariates2014[extended_covariates2014$SAMPLING_EVENT_ID %in% Survey,]
extended_covariates2015a<- extended_covariates2015[extended_covariates2015$SAMPLING_EVENT_ID %in% Survey,]
extended_covariates2016a<- extended_covariates2016[extended_covariates2016$SAMPLING_EVENT_ID %in% Survey,]


# combine all filtered land cover classifications into one dataframe --------


#To combine all the imported covariate datasets into one, use dplyr::rbind_all(), bind_rows() works as well
covariates2002_2016<-dplyr::bind_rows(extended_covariates2002a, 
                 extended_covariates2003a,
                 extended_covariates2004a,
                 extended_covariates2005a,
                 extended_covariates2006a,
                 extended_covariates2007a,
                 extended_covariates2008a,
                 extended_covariates2009a,
                 extended_covariates2010a,
                 extended_covariates2011a,
                 extended_covariates2012a,
                 extended_covariates2013a,
                 extended_covariates2014a,
                 extended_covariates2015a,
                 extended_covariates2016a)
covariates2002_2016 #3930 rows of data


# combine ebird checklist and landcover data and write to a single csv file -------

allGBChecklists1988_2016$landcover<- #add a column called landcover to the checklist data
  covariates2002_2016$UMD_LANDCOVER[ #Use the rows in the Landcover value from the covariate data 
    match #The match function selects rows in one dataframe that match the rows in another data frame
                                    (allGBChecklists1988_2016$`SAMPLING EVENT IDENTIFIER`,#find samling events in the checklist data
                                      covariates2002_2016$SAMPLING_EVENT_ID)]#Find matching sampling events in the covariate data

allGBChecklists1988_2016$landcoverYR<- #add a column called landcover to the checklist data
  covariates2002_2016$YEAR[ #Use the rows in the Year value from the covariate data 
    match #The match function selects rows in one dataframe that match the rows in another data frame
    (allGBChecklists1988_2016$`SAMPLING EVENT IDENTIFIER`,#find sampling events in the checklist data
      covariates2002_2016$SAMPLING_EVENT_ID)]#Find matching sampling events in the covariate data

allGBChecklists1988_2016 #checklist data now has additional columns called landcover and landcoverYR
write_csv(allGBChecklists1988_2016, "allGBChecklists1988_2016.csv")

# #filter for desired variables --------
ebirdGB2016<-data.frame(allGBChecklists1988_2016$LOCALITY,
                        allGBChecklists1988_2016$`LOCALITY ID`,
                        allGBChecklists1988_2016$LATITUDE,
                        allGBChecklists1988_2016$LONGITUDE,
                        allGBChecklists1988_2016$`SAMPLING EVENT IDENTIFIER`,
                        allGBChecklists1988_2016$`OBSERVATION DATE`,
                        allGBChecklists1988_2016$`OBSERVATION COUNT`,
                        allGBChecklists1988_2016$`TIME OBSERVATIONS STARTED`,
                        allGBChecklists1988_2016$`DURATION MINUTES`,
                        allGBChecklists1988_2016$`OBSERVER ID`,
                        allGBChecklists1988_2016$`FIRST NAME`,
                        allGBChecklists1988_2016$`LAST NAME`,
                        allGBChecklists1988_2016$`COMMON NAME`,
                        allGBChecklists1988_2016$`SCIENTIFIC NAME`,
                        allGBChecklists1988_2016$landcover,
                        allGBChecklists1988_2016$landcoverYR)

# rename columns to match variable names ----------------------------------

#create vector of variable names
variables<-c('locality',
             'LOCID',
             'Latitude',
             'Longitude',
             'Survey',
             'Date',
             'Count',
             'Time',
             'Duration',
             'OBSID',
             'FirstName',
             'LastName',
             'Comname',
             'Sciname',
             'Landcover',
             'LandcoverYR')
#rename the columns using the variable names
colnames(ebirdGB2016)<-variables
colnames(ebirdGB2016)
