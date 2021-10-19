source("2_process/src/process_and_style.R")

p2_targets_list <- list(
  tar_target(
    p2_site_data_clean, 
    process_data(p1_site_data_concat)
  ),
  tar_target(
    p2_site_data_annotated,
    annotate_data(p2_site_data_clean, site_filename = p1_site_info_csv)
  ),
  tar_target(
    p2_site_data_styled,
    style_data(p2_site_data_annotated)
  )
)