source("1_fetch/src/get_nwis_data.R")

p1_targets_list <- list(
  tar_target(
    nwis_01427207_data,
    download_nwis_site_data_object("01427207")
  ),
  tar_target(
    nwis_01432160_data,
    download_nwis_site_data_object("01432160")
  ),
  tar_target(
    nwis_01435000_data,
    download_nwis_site_data_object("01435000")
  ),
  tar_target(
    nwis_01436690_data,
    download_nwis_site_data_object("01436690")
  ),
  tar_target(
    nwis_01466500_data,
    download_nwis_site_data_object("01466500")
  ),
  tar_target(
    site_data_concat,
    concat_files_to_df(target_object_1 = nwis_01427207_data, target_object_2 = nwis_01432160_data, target_object_3 = nwis_01435000_data, target_object_4 = nwis_01436690_data, target_object_5 = nwis_01466500_data)
  ),
  tar_target(
    site_info_csv,
    nwis_site_info(fileout = '1_fetch/out'),
    format = "file"
  )
)