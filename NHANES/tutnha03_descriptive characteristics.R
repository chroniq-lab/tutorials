rm(list=ls());gc();source(".Rprofile")


analytic_sample = readRDS(paste0(path_chroniq_lab,"/NHANES/tutnha02.RDS")) %>% 
  dplyr::filter(year == "20212023")


# Method 1: Using survey -----------
library(survey)
# Define survey design
# This is only for one round
# To combine multiple rounds, follow these instructions:
# https://wwwn.cdc.gov/nchs/nhanes/continuousnhanes/overviewbrief.aspx?Cycle=2017-2020 >> 
# If done, the survey weights should be adjusted to reflect the longer period and larger population represented by the 2017-March 2020 files. 
# For example, combining the 2015-2016 and 2017-March 2020 files would result in a data file representing a 5.2-year period, and the survey weights should be adjusted as follows: 
# 2015-2016 survey weights should be multiplied by 2/5.2 (the fraction of the 5.2-year period represented by the 2015-2016 cycle) and 
# likewise, the 2017-March 2020 survey weights should be multiplied by 3.2/5.2.
# For 1999-2000 and 2001-2002, use mec4yweight --> divide by 4

# Example: Combining 1999-2000 to 2017-March 2020
# Y1 - Y2: weight chosen --> contribution -------
# 1999-2000: mec4yweight --> 4
# 2001-2002: mec4yweight --> 4
# 2003-2004: mec2yweight --> 2
# 2005-2006: mec2yweight --> 2
# 2007-2008: mec2yweight --> 2
# 2009-2010: mec2yweight --> 2
# 2011-2012: mec2yweight --> 2
# 2013-2014: mec2yweight --> 2
# 2015-2016: mec2yweight --> 2
# 2017-2018: mec2yweight --> 2
# 2019-Mar2020: mec2yweight --> 2
# 2021-2023: mec2yweight --> 2

# If using 2017-Mar2020: mec2yweight --> 2

# 1. Denominator: Add up the contributions from all waves
# 2. Numerator: mec2yweight*contribution from the waves 

analytic_sample_svy <- svydesign(id = ~psu, strata = ~pseudostratum, weights = ~mec2yweight, data = analytic_sample, nest = TRUE)

svymean(~age,analytic_sample_svy)
svyvar(~age,analytic_sample_svy) %>% sqrt()
svyciprop(~female,analytic_sample_svy)

# Method 2: Using srvyr
library(srvyr)
analytic_sample_svy2 = analytic_sample %>% 
  as_survey_design(ids = psu,strata= pseudostratum,
                   weights=mec2yweight, 
                   nest = TRUE, 
                   ps = "brewer",variance = "YG")


analytic_sample_svy2 %>% 
  summarize(mean_age = survey_mean(age,vartype="ci"))

analytic_sample_svy2 %>% 
  group_by(female) %>% 
  summarize(prop_female = survey_prop())


# Method 3: Using custom function
# https://github.com/jvargh7/functions

source("C:/code/external/functions/survey/svysummary.R")

output = svysummary(analytic_sample_svy2,
           c_vars=c("age"),
           p_vars=c("female"))

write_csv(output,paste0(path_chroniq_lab,"/NHANES/tutnha03_output.csv"))
