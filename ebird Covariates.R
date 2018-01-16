# eBird covariates import
# This import from the eBird Extended Covariates files includes:
#   the Sampling Event, Locality, UMD Land Cover Classification and Water Classification

setwd("C:/Users/davisao2/Desktop/open source GIS/eBird r code/eBird 2016/ERD2016SS/All years/Bahamas Covariates")
#The extended covariates files have been downloaded and unzipped into the working directory as csv files.
#extract only the Locality ID, Sampling Event ID, Landvocer Classification, Watercover Classification, and Year

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

#Combine all the land cover classification into one data set

#To combine all the imported covariate datasets into one, use dplyr::rbind_all(), bind_rows() works as well
covariates2002_2016<-dplyr::bind_rows(extended_covariates2002, 
                 extended_covariates2003,
                 extended_covariates2004,
                 extended_covariates2005,
                 extended_covariates2006,
                 extended_covariates2007,
                 extended_covariates2008,
                 extended_covariates2009,
                 extended_covariates2010,
                 extended_covariates2011,
                 extended_covariates2012,
                 extended_covariates2013,
                 extended_covariates2014,
                 extended_covariates2015,
                 extended_covariates2016)
