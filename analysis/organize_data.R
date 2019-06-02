#' ---
#' title: "organize_data.R"
#' author: ""
#' ---

# This script will read in raw data from the input directory, clean it up to produce 
# the analytical dataset, and then write the analytical data to the output directory. 

#source in any useful functions
#source("useful_functions.R")

library(readr)

sexharass <- read_fwf("analysis/input/sexharrass_fwf_fixed.txt",
                      col_positions = fwf_positions(start=c( 1,92,94,96,98,100,102,104,106,108,110,112,123,125,127,129,131),
                                                    end=  c(21,93,95,97,99,101,103,105,107,109,111,121,124,126,128,130,132),
                                                    col_names=c("controlblock","Q27A","Q27B","Q27C","Q27D","Q27E","Q27F","Q27G","Q27H","Q27I","Q27J","Q28","Q30A","Q30B","Q30C","Q30D","Q30E"),
                                                    trims_ws=FALSE))

sexharass <- na.omit(sexharass)
sexharass$invest <- NA
sexharass$invest[sexharass$Q30A=="1" | sexharass$Q30A=="11"] <- "internalbetter"
sexharass$invest[sexharass$Q30A=="2" | sexharass$Q30A=="12"] <- "internalneutral"
sexharass$invest[sexharass$Q30A=="3" | sexharass$Q30A=="13"] <- "internalworse"

sexharass$invest[sexharass$Q30B=="1" | sexharass$Q30B=="11"] <- "outsidebetter"
sexharass$invest[sexharass$Q30B=="2" | sexharass$Q30B=="12"] <- "outsideneutral"
sexharass$invest[sexharass$Q30B=="3" | sexharass$Q30B=="13"] <- "outsideworse"

sexharass$invest[sexharass$Q30C=="1" | sexharass$Q30C=="11"] <- "unionbetter"
sexharass$invest[sexharass$Q30C=="2" | sexharass$Q30C=="12"] <- "unionneutral"
sexharass$invest[sexharass$Q30C=="3" | sexharass$Q30C=="13"] <- "unionworse"

sexharass$invest[sexharass$Q30D=="1" | sexharass$Q30D=="11"] <- "EEObetter"
sexharass$invest[sexharass$Q30D=="2" | sexharass$Q30D=="12"] <- "EEOneutral"
sexharass$invest[sexharass$Q30D=="3" | sexharass$Q30D=="13"] <- "EEOworse"

sexharass$invest[sexharass$Q30E=="1" | sexharass$Q30E=="11"] <- "otherbetter"
sexharass$invest[sexharass$Q30E=="2" | sexharass$Q30E=="12"] <- "otherneutral"
sexharass$invest[sexharass$Q30E=="3" | sexharass$Q30E=="13"] <- "otherworse"

sexharass$invest <- factor(sexharass$invest, levels=c("internalworse", "internalneutral", "internalbetter","outsideworse", "outsideneutral", "outsidebetter","unionworse", "unionneutral", "unionbetter","EEOworse", "EEOneutral", "EEObetter","otherworse", "otherneutral", "otherbetter"), ordered=TRUE)


#sexharass$action <- NA
#sexharass$action[sexharass$Q27A==]
#code question 27 as actions taken, better worse neutral
#code question 28 somehow??? collapse down to positive negative neutral outcomes