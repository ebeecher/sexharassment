#' ---
#' title: "organize_data.R"
#' author: ""
#' ---

# This script will read in raw data from the input directory, clean it up to produce 
# the analytical dataset, and then write the analytical data to the output directory. 

#source in any useful functions
#source("useful_functions.R")

library(readr)

sexharass <- read_fwf("analysis/input/sexharrass_fwf_fixed.txt", trim_ws = FALSE,
                      col_positions = fwf_positions(start=c( 1,66,67,68,69,70,71,72,73,92,94,96,98,100,101,
                                                             102,104,106,108,110,112,123,125,127,129,131,211),
                                                    end=  c(21,66,67,68,69,70,71,72,73,93,95,97,99,100,101,
                                                            103,105,107,109,111,121,124,126,128,130,132,211),
                                                    col_names=c("controlblock","Q20A","Q20B","Q20C","Q20D",
                                                                "Q20E","Q20F","Q20G","Q20H","Q27A","Q27B",
                                                                "Q27C","Q27D","Q27Ei","Q27Eii","Q27F","Q27G","Q27H",
                                                                "Q27I","Q27J","Q28","Q30A","Q30B","Q30C",
                                                                "Q30D","Q30E","sex")))

#Am I dealing with missing values correctly?

#sexharass <- na.omit(sexharass)

#Q20: did they experience sex harassment with degrees of frequency 
#(282 people experienced an incident and 7799 didn't)
sexharass$incident <- NA
sexharass$incident[sexharass$incident==" "] <- NA
sexharass$incident <- sexharass$Q20A!="1" & sexharass$Q20B!="1" & sexharass$Q20C!="1" & 
  sexharass$Q20D!="1" & sexharass$Q20E!="1" & sexharass$Q20F!="1" & sexharass$Q20G!="1" & 
  sexharass$Q20H!="1"

#Q27E: what did you do in response to harassment - file a complaint including outcome value
#I think this solves my outcome variable problem
sexharass$file_complaint <- NA
sexharass$file_complaint <- sexharass$Q27Ei=="1"
sexharass$file_pos <- NA
sexharass$file_pos <- sexharass$Q27Eii=="1"
sexharass$file_neutral <- NA
sexharass$file_neutral <- sexharass$Q27Eii=="2"
sexharass$file_worse <- NA
sexharass$file_worse <- sexharass$Q27Eii=="3"

#Q28: positive, negative, neutral outcome, asked of everyone.
#I don't think this variable is going to work because they were asked to answer this question
#in direct response to the instance of sexual harassment - almost no one is going to say that 
#their lives got better because of sexual harassment, even if they filed a grievance to take care of it
sexharass$work_worse <- substr(sexharass$Q28, 1, 1)=="1"
sexharass$bad_ref <- substr(sexharass$Q28, 2, 2)=="1"
sexharass$transfer <- substr(sexharass$Q28, 3, 3)=="1"
sexharass$fired <- substr(sexharass$Q28, 4, 4)=="1"
sexharass$quit_newjob <- substr(sexharass$Q28, 5, 5)=="1"
sexharass$quit_nojob <- substr(sexharass$Q28, 6, 6)=="1"

sexharass$good_outcome <- substr(sexharass$Q28, 7, 7)=="2"
sexharass$neutral_outcome <- substr(sexharass$Q28, 8, 8)=="3"

sexharass$bad_outcome <- sexharass$work_worse | sexharass$bad_ref | sexharass$transfer | 
  sexharass$fired | sexharass$quit_newjob | sexharass$quit_nojob

#how do I drop the cases for the outcome variables for people who didn't experience an incident?
#code for if people answered more than one


#Q30: kind of investigation pursued, asked of people who had an incident
#(regardless of outcome)

sexharass$internalinvest <- NA
sexharass$internalinvest <- sexharass$Q30A!="   "

sexharass$outsideinvest <- NA
sexharass$outsideinvest <- sexharass$Q30B!="  "

sexharass$grievance <- NA
sexharass$grievance <- sexharass$Q30C!="  "

sexharass$eeoinvest <- NA
sexharass$eeoinvest <- sexharass$Q30D!="  "

sexharass$otherinvest <- NA
sexharass$otherinvest <- sexharass$Q30E!="  "

#Q69 - sex: to control for sex
sexharass$sex[sexharass$sex==" "] <- NA
sexharass$sex[sexharass$sex=="1"] <- "male"
sexharass$sex[sexharass$sex=="2"] <- "female"

#data incident subset
sexharass <- subset(sexharass, incident, 
                    select=c("file_complaint", "good_outcome", "neutral_outcome", "bad_outcome", 
                             "internalinvest", "outsideinvest", "grievance", "eeoinvest", "sex"))

save(sexharass, file="analysis/output/data.RData")
