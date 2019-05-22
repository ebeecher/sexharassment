#' ---
#' title: "organize_data.R"
#' author: ""
#' ---

# This script will read in raw data from the input directory, clean it up to produce 
# the analytical dataset, and then write the analytical data to the output directory. 

#source in any useful functions
#source("useful_functions.R")

library(readr)

sexharass <- read_fwf("input/sexharrass_fwf_fixed.txt",
                      col_positions = fwf_positions(start=c( 1,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,42,43,44,45,46,47,55,65,66,67,68,69,70,71,72,73,74,75,100,101,123,124),
                                                    end=  c(21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,41,42,43,44,45,46,54,64,65,66,67,68,69,70,71,72,73,74,80,100,101,123,124),
                                                    col_names=c("controlblock", "Q1A","Q1B","Q2A","Q2B","Q3A","Q3B","Q4A",
                                                                "Q4B","Q5A","Q5B","Q6A","Q6B","Q7","Q8","Q9","Q10","Q11",
                                                                "Q12","Q13","Q14","Q15","Q16","Q17","Q18","Q19","Q20A",
                                                                "Q20B","Q20C","Q20D","Q20E","Q20F","Q20G","Q20H","Q21","Q22","Q27E1","Q27E2","Q30A1","Q30A2")))
