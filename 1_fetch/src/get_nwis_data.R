#function for downloading data to targets object 
download_nwis_site_data_object <- function(site_num){
  # readNWISdata is from the dataRetrieval package
  data_out <- readNWISdata(sites=site_num, service="iv", 
                           parameterCd = '00010', startDate="2014-05-01", endDate="2015-05-01")
  
  # -- simulating a failure-prone web-sevice here, do not edit --
  set.seed(Sys.time())
  if (sample(c(T,F,F,F), 1)){
    stop(site_num, ' has failed due to connection timeout. Try tar_make() again')
  }
  # -- end of do-not-edit block
  #write_csv(data_out, file = download_files_to)
  return(data_out)
}

concat_files_to_df <- function(target_object_1, target_object_2, target_object_3, target_object_4, target_object_5){

  data_out <- bind_rows(target_object_1, target_object_2, target_object_3, target_object_4, target_object_5)
  return(data_out)
}

nwis_site_info <- function(fileout){
  site_info <- dataRetrieval::readNWISsite(siteNumbers=c("01427207", "01432160","01435000", "01436690", "01466500"))
  write_csv(site_info, file.path(fileout,'p1_site_info.csv'))
  return(file.path(fileout,'p1_site_info.csv'))
}