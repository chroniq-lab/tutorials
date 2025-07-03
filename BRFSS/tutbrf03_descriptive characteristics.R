
rm(list=ls());gc();source(".Rprofile")


clean_brfss = readRDS(paste0(path_chroniq_lab,"/BRFSS/tutbrf02.RDS"))

brfss_sample_svy <- clean_brfss %>%
  dplyr::rename(PSU = "_PSU",
                STSTR = "_STSTR",
                LLCPWT = "_LLCPWT")  %>% 
  as_survey_design(.data = .,
                   ids = PSU,
                   strata = STSTR,
                   weights = LLCPWT, 
                   nest = TRUE, 
                   ps = "brewer",variance = "YG")

# For Method 1 and Method 2, see 
# Method 3: Using custom function
# https://github.com/jvargh7/functions

source("C:/code/external/functions/survey/svysummary.R")

# This might take a little bit of time because it's a large dataset
output = svysummary(brfss_sample_svy,
                    c_vars=c("WTKG3"),
                    p_vars=c("female"))

write_csv(output,paste0(path_chroniq_lab,"/BRFSS/tutbrf03_output.csv"))