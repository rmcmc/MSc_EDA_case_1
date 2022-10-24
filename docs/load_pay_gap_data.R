## Purpose: EDA 1
## Author: Karthik Paranthaman
## Date: 2022-10-10

## load packages----
if (!require("pacman")) install.packages("pacman")
pacman::p_load(janitor, tidyverse, lubridate)

## load and clean data----
univ_data <- read_csv("../data/universities.csv")

pay_data_files <- list.files("../data/", pattern = ".*Pay.*", full.names = T) 

raw_pay_data <- pay_data_files |> 
  set_names() |> 
  map_dfr(read_csv, .id = "yr") |> 
  mutate(yr =gsub(".*([0-9]{4}) to .*([0-9]{2}).*", "\\1-\\2", yr))

df <- inner_join(univ_data, raw_pay_data, by = "EmployerId") |> 
  clean_names() |> 
  select(employer_name = employer_name_x, 
         employer_id, 
         pre92, 
         yr, 
         diff_mean_hourly_percent:female_top_quartile,
         employer_size) 

