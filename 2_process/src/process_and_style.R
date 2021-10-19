process_data <- function(nwis_data, clean_data_to){
  nwis_data_clean <- rename(nwis_data, water_temperature = X_00010_00000) %>% 
    select(-agency_cd, -X_00010_00000_cd, -tz_cd)
  
  return(nwis_data_clean)
}

annotate_data <- function(site_data_clean, site_filename, save_annotated_data_csv){
  site_info <- read_csv(site_filename)
  annotated_data <- left_join(site_data_clean, site_info, by = "site_no") %>% 
    select(station_name = station_nm, site_no, dateTime, water_temperature, latitude = dec_lat_va, longitude = dec_long_va)
  write.csv(annotated_data, save_annotated_data_csv)
  return(save_annotated_data_csv)
}


style_data <- function(site_data_annotated_csv){
  site_data_annotated <- read_csv(site_data_annotated_csv)
  mutate(site_data_annotated, station_name = as.factor(station_name))
}