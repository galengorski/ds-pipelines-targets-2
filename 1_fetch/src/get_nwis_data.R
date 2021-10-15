
download_nwis_site_data <- function(site_num, download_files_to){
  # readNWISdata is from the dataRetrieval package
  data_out <- readNWISdata(sites=site_num, service="iv", 
                           parameterCd = '00010', startDate="2014-05-01", endDate="2015-05-01")
  
  # -- simulating a failure-prone web-sevice here, do not edit --
  set.seed(Sys.time())
  if (sample(c(T,F,F,F), 1)){
    stop(site_num, ' has failed due to connection timeout. Try tar_make() again')
  }
  # -- end of do-not-edit block
  write_csv(data_out, file = download_files_to)
  return(download_files_to)
}

concat_files_to_df <- function(csv_1, csv_2, csv_3, csv_4, csv_5){
  downloaded_files <- c(csv_1, csv_2, csv_3, csv_4, csv_5)
  data_out <- data.frame()
  for(df in downloaded_files){
    these_data <- read_csv(df, col_types = 'ccTdcc')
    data_out <- bind_rows(data_out, these_data)
  }
  return(data_out)
}

nwis_site_info <- function(fileout){
  site_info <- dataRetrieval::readNWISsite(siteNumbers=c("01427207", "01432160","01435000", "01436690", "01466500"))
  write_csv(site_info, file.path(fileout,'site_info.csv'))
  return(file.path(fileout,'site_info.csv'))
}