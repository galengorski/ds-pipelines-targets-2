library(targets)
source("1_fetch/src/get_nwis_data.R")
source("2_process/src/process_and_style.R")
source("3_visualize/src/plot_timeseries.R")

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse", "dataRetrieval")) # Loading tidyverse because we need dplyr, ggplot2, readr, stringr, and purrr
#site numbers
sites = c("01427207", "01432160","01435000", "01436690", "01466500")
#parameter codes for query
parameterCd = '00010' 
startDate="2014-05-01" 
endDate="2015-05-01"
#parameters for plotting
p_width <- 12
p_height <- 7
p_units <- "in"

p1_targets_list <- list(
  tar_target(
    create_directories,
    create_dirs(sites),
    format = "file"
  ),
  tar_target(
    site_data_1,
    download_nwis_site_data(sites[1], create_directories,parameterCd, startDate, endDate),
    format = "file"
  ),
  tar_target(
    site_data_2,
    download_nwis_site_data(sites[2], create_directories,parameterCd, startDate=, endDate=),
    format = "file"
  ),
  tar_target(
    site_data_3,
    download_nwis_site_data(sites[3], create_directories,parameterCd, startDate=, endDate=),
    format = "file"
  ),
  tar_target(
    site_data_4,
    download_nwis_site_data(sites[4], create_directories,parameterCd, startDate=, endDate=),
    format = "file"
  ),
  tar_target(
    site_data_5,
    download_nwis_site_data(sites[5], create_directories,parameterCd, startDate=, endDate=),
    format = "file"
  ),
  tar_target(
    site_data_concat,
    concat_files_to_df()
  ),
  tar_target(
    site_info_csv,
    nwis_site_info(fileout = '1_fetch/out', sites = sites),
    format = "file"
  )
)

p2_targets_list <- list(
  tar_target(
    site_data_clean, 
    process_data(site_data_concat)
  ),
  tar_target(
    site_data_annotated,
    annotate_data(site_data_clean, site_filename = site_info_csv)
  ),
  tar_target(
    site_data_styled,
    style_data(site_data_annotated)
  )
)

p3_targets_list <- list(
  tar_target(
    figure_1_png,
    plot_nwis_timeseries(fileout = "3_visualize/out/figure_1.png", site_data_styled,
                         width = p_width, height = p_height, units = p_units),
    format = "file"
  )
)

# Return the complete list of targets
c(p1_targets_list, p2_targets_list, p3_targets_list)
