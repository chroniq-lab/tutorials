# Refer to C:\code\external\nhanes_ckm
# https://github.com/jvargh7/nhanes_ckm

library(haven)
library(tidyverse)

source("C:/code/external/nhanes_ckm/data/ncdat_read all variable lists.R")


path_nhanes_ckm_folder <- "C:/Cloud/OneDrive - Emory University/Papers/NHANES Subtypes Mortality"
path_nhanes_ckm_repo <- "C:/code/external/nhanes_ckm"

path_nhanes_ckm_variable_list <- paste0(path_nhanes_ckm_repo,"/data/CKM Variable List.xlsx")
path_nhanes_ckm_raw = paste0(path_nhanes_ckm_folder,"/working/raw")


# Loading in the 2017-Mar2020 datasets:
alb2017Mar2020 <- read_xpt(paste0(path_nhanes_ckm_raw,"/2017-Mar2020/P_ALB_CR.XPT")) %>%
  # Select columns
  select(all_of(na.omit(alb_variables$`2017-Mar2020`))) %>%
  # Rename columns
  rename_with(~ alb_variables[!is.na(alb_variables$`2017-Mar2020`),]$variable[which(na.omit(alb_variables$`2017-Mar2020`) == .x)], 
              .cols = na.omit(alb_variables$`2017-Mar2020`))


saveRDS(alb2017Mar2020,paste0(path_chroniq_lab,"/NHANES/tutnha01.RDS"))
