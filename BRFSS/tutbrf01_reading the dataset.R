# Refer to https://github.com/jvargh7/spatial_kiosks
rm(list=ls());gc();source(".Rprofile")

path_data_sharing_folder = "C:/Cloud/OneDrive - Emory University/Data Sharing"

brfss2022 = haven::read_xpt(paste0(path_data_sharing_folder,"/BRFSS/LLCP2022.xpt"),col_select = c("SEQNO","_STATE","IMONTH","IYEAR","DISPCODE",
                                                                                                  "_PSU","_STSTR","_LLCPWT",
                                                                                                  "LADULT1","SEXVAR","_SEX","_AGEG5YR","HTM4","WTKG3","_BMI5","_BMI5CAT",
                                                                                                  "_RACEPR1","_URBSTAT"))


saveRDS(brfss2022,paste0(path_chroniq_lab,"/BRFSS/tutbrf01.RDS"))

