create_dirs <- function(site_num){
  download_files_to <- file.path('1_fetch/out', paste0('nwis_', site_num, '_data.csv'))
  return(download_files_to)
}

download_nwis_site_data <- function(site_num, download_files_to, parameterCd = '00010', startDate="2014-05-01", endDate="2015-05-01"){
  
  # readNWISdata is from the dataRetrieval package
  data_out <- readNWISdata(sites=site_num, service="iv", 
                           parameterCd = parameterCd, startDate = startDate, endDate = endDate)
  
  # -- simulating a failure-prone web-sevice here, do not edit --
  set.seed(Sys.time())
  if (sample(c(T,F,F,F), 1)){
    stop(site_num, ' has failed due to connection timeout. Try tar_make() again')
  }
  # -- end of do-not-edit block
  correct_dir <- download_files_to[grep(site_num,download_files_to)]
  write_csv(data_out, file = correct_dir)
  return(correct_dir)
}

concat_files_to_df <- function(){
  downloaded_data <- list.files(path = '1_fetch/out', pattern = '_data.csv', full.names = T)
  data_out <- data.frame()
  for(downloaded_data in downloaded_data){
    these_data <- read_csv(downloaded_data, col_types = 'ccTdcc')
    data_out <- bind_rows(data_out, these_data)
  }
  return(data_out)
}

nwis_site_info <- function(fileout, sites){
  site_info <- dataRetrieval::readNWISsite(sites)
  write_csv(site_info, file.path(fileout,'site_info.csv'))
  return(file.path(fileout,'site_info.csv'))
}