source("1_fetch/src/get_nwis_data.R")

p1_targets_list <- list(
  tar_target(
    p1_nwis_01427207_data,
    download_nwis_site_data_object("01427207")
  ),
  tar_target(
    p1_nwis_01432160_data,
    download_nwis_site_data_object("01432160")
  ),
  tar_target(
    p1_nwis_01435000_data,
    download_nwis_site_data_object("01435000")
  ),
  tar_target(
    p1_nwis_01436690_data,
    download_nwis_site_data_object("01436690")
  ),
  tar_target(
    p1_nwis_01466500_data,
    download_nwis_site_data_object("01466500")
  ),
  tar_target(
    p1_site_data_concat,
    concat_files_to_df(target_object_1 = p1_nwis_01427207_data, target_object_2 = p1_nwis_01432160_data, target_object_3 = p1_nwis_01435000_data, target_object_4 = p1_nwis_01436690_data, target_object_5 = p1_nwis_01466500_data)
  ),
  tar_target(
    p1_site_info_csv,
    nwis_site_info(fileout = '1_fetch/out'),
    format = "file"
  )
)