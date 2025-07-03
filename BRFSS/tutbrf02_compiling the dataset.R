rm(list=ls());gc();source(".Rprofile")

# Refer https://github.com/jvargh7/spatial_kiosks/blob/main/code/data_acquisition/write_and_clean_brfss.R
clean_brfss = readRDS(paste0(path_chroniq_lab,"/BRFSS/tutbrf01.RDS")) |>
  mutate(sex = case_when( 
    `_SEX` == 1 ~ "Male",
    `_SEX` == 2 ~ "Female"),
    
    female = case_when(
      `_SEX` == 1 ~ 0,
      `_SEX` == 2 ~ 1,
      TRUE ~ NA_real_
    ),
    
    urban = case_when(
    `_URBSTAT` == 1 ~ "urban",
    `_URBSTAT` == 2 ~ "rural"
  ),

  race = case_when(
    `_RACEPR1` == 1 ~ "NH white",
    `_RACEPR1` == 2 ~ "NH black",
    `_RACEPR1` %in% c(3,5,6) ~ "NH other",
    `_RACEPR1` == 4 ~ "NH asian",
    `_RACEPR1` == 7 ~ "Hispanic"
  )) |>
  mutate(age_group = case_when(
    `_AGEG5YR` %in% sprintf("%02d", 1:5) ~ "18-44",
    `_AGEG5YR` %in% sprintf("%02d", 6:9) ~ "45-64",
    `_AGEG5YR` %in% sprintf("%02d", 10:13) ~ "65+",
    `_AGEG5YR` %in% 14 ~ "Missing"
  )) |>
  
  # please remember that the exclusions and variable coding are dependent on your specific analysis
  filter(age_group != "Missing") |>
  filter(!is.na(urban)) %>% 
  dplyr::filter(!is.na(WTKG3))

saveRDS(clean_brfss,paste0(path_chroniq_lab,"/BRFSS/tutbrf02.RDS"))
