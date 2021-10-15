library(targets)
source("1_fetch/src/get_nwis_data.R")
source("2_process/src/process_and_style.R")
source("3_visualize/src/plot_timeseries.R")

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse", "dataRetrieval")) # Loading tidyverse because we need dplyr, ggplot2, readr, stringr, and purrr
#site numbers
#sites = c("01427207", "01432160","01435000", "01436690", "01466500")
#parameter codes for query



p1_targets_list <- list(
  # tar_target(
  #   create_directories,
  #   create_dirs(site_num = c("01427207", "01432160","01435000", "01436690", "01466500")),
  #   format = "file"
  # ),
  tar_target(
    nwis_01427207_data_csv,
    download_nwis_site_data("01427207","nwis_01427207_data.csv"),
    format = "file"
  ),
  tar_target(
    nwis_01432160_data_csv,
    download_nwis_site_data("01432160","nwis_01432160_data.csv"),
    format = "file"
  ),
  tar_target(
    nwis_01435000_data_csv,
    download_nwis_site_data("01435000","nwis_01435000_data.csv"),
    format = "file"
  ),
  tar_target(
    nwis_01436690_data_csv,
    download_nwis_site_data("01436690","nwis_01436690_data.csv"),
    format = "file"
  ),
  tar_target(
    nwis_01466500_data_csv,
    download_nwis_site_data("01466500","nwis_01466500_data.csv"),
    format = "file"
  ),
  tar_target(
    site_data_concat,
    concat_files_to_df(c(nwis_01427207_data_csv, nwis_01432160_data_csv, nwis_01435000_data_csv, nwis_01436690_data_csv, nwis_01466500_data_csv))
  ),
  tar_target(
    site_info_csv,
    nwis_site_info(fileout = '1_fetch/out'),
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
                         width = 12, height = 7, units = "in"),
    format = "file"
  )
)

# Return the complete list of targets
c(p1_targets_list, p2_targets_list, p3_targets_list)
