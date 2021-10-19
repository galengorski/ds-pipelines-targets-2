library(targets)

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse", "dataRetrieval")) 

source('1_fetch.R')
source('2_process.R')
source('3_visualize.R')

c(p1_targets_list, p2_targets_list, p3_targets_list)
