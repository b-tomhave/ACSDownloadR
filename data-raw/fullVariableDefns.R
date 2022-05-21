## code to prepare `fullVariableDefns` dataset goes here
# CENSUS_API_KEY loaded to .renviron in file "CensusKey.R" not uploaded to GitHub
library(tidycensus) # Package Guide Here: https://walker-data.com/census-r/an-introduction-to-tidycensus.html
states <- tidycensus::state_laea

fipsCodes <- data.table::data.table(tidycensus::fips_codes)[!(state_name %in% c("American Samoa",
                                                                                "Guam",
                                                                                "Northern Mariana Islands",
                                                                                "Puerto Rico",
                                                                                "U.S. Minor Outlying Islands",
                                                                                "U.S. Virgin Islands"))]
shinyWidgets::shinyWidgetsGallery()
usethis::use_data(fipsCodes, overwrite = TRUE)

# Counties By State Input
countySubset <- fipsCodes[state_name %in% c("Minnesota", "Wisconsin")]
test3 <- split(countySubset$county, countySubset$state_name)
test2 <- list (countySubset$state_name, countySubset$county)
test <- list(
  Minneapolis = c('1', '2','4'),
  `St. Paul` = c('45','2','2')
)

# Get ACS Detailed Tables Data
varList <- tidycensus::load_variables(
  year = 2019,
  dataset = "acs5",
  cache = TRUE
)


# Get ACS Profile Data
varList <- tidycensus::load_variables(
  year = 2019,
  dataset = "acs5/profile",
  cache = TRUE
)

hhinc_wide <- get_acs(
  geography = "state",
  table = "B19001",
  survey = "acs1",
  year = 2016,
  output = "wide" # Data can be returned in long or wide format
)

# Can Rename Vars
ga <- get_acs(
  geography = "county",
  state = "Georgia",
  variables = c("medinc_B19013" = "B19013_001",
                medage = "B01002_001"),
  output = "wide",
  year = 2020
)

ga <- get_acs(
  geography = "county",
  state = "Georgia",
  table = "B19013",
  year = 2020
)

# Sort
# arrange(median_age, estimate)

# Filter (By Row)
# filter(median_age, estimate >= 50)

# Separate Splits Into Multiple Columns
# separate(
#   median_age,
#   NAME,
#   into = c("county", "state"),
#   sep = ", "
# )

v16 <- load_variables(2016, "acs5", cache = TRUE)


# Use summary_var to callout baseline for each table
race_vars <- c(
  White = "B03002_003",
  Black = "B03002_004",
  Native = "B03002_005",
  Asian = "B03002_006",
  HIPI = "B03002_007",
  Hispanic = "B03002_012"
)

az_race <- get_acs(
  geography = "county",
  state = "AZ",
  variables = race_vars,
  summary_var = "B03002_001",
  year = 2020
)

# Easy Pct Calcs
library(dplyr)
az_race_percent <- az_race %>%
  mutate(percent = 100 * (estimate / summary_est)) %>%
  select(NAME, variable, percent)

# Groupwise Comparisons
largest_group <- az_race_percent %>%
  group_by(NAME) %>%
  filter(percent == max(percent))

az_race_percent %>%
  group_by(variable) %>%
  summarize(median_pct = median(percent))


# Recoding with custom groups
mn_hh_income <- get_acs(
  geography = "county",
  table = "B19001",
  state = "MN",
  year = 2020
)

mn_hh_income_recode <- mn_hh_income %>%
  filter(variable != "B19001_001") %>%
  mutate(incgroup = case_when(
    variable < "B19001_008" ~ "below35k", # All vars before 008
    variable < "B19001_013" ~ "bw35kand75k", # Vars 008-012
    TRUE ~ "above75k"
  ))

mn_group_sums <- mn_hh_income_recode %>%
  group_by(GEOID,NAME, incgroup) %>%
  summarize(estimate = sum(estimate))



# VIZ

maine <- get_decennial(
  state = "Maine",
  geography = "county",
  variables = c(totalpop = "P1_001N"),
  year = 2020
) %>%
  arrange(desc(value))

library(stringr)
mn_income <- get_acs(
  state = "MN",
  geography = "county",
  variables = c(hhincome = "B19013_001"),
  year = 2020
) %>%
  mutate(NAME = stringr::str_remove(NAME, " County, Minnesota"))

library(ggplot2)
library(scales) # GGPLOT Formatting
ggplot(mn_income, aes(x = estimate, y = reorder(NAME, estimate))) +
  geom_errorbarh(aes(xmin = estimate - moe, xmax = estimate + moe)) +
  geom_point(size = 3, color = "darkgreen") +
  theme_minimal(base_size = 12.5) +
  labs(title = "Median household income",
       subtitle = "Counties in Minnesota",
       x = "2016-2020 ACS estimate",
       y = "") +
  scale_x_continuous(labels = label_dollar())

# Data REturned with Four Columns:
# GEOID
# NAME: Geog Name
# Variable: Variable Name
# Estimate and mode = value and error

total_population_10 <- tidycensus::get_decennial(
  geography = "state",
  variables = "P001001",
  year = 2010
)


# Get ACS Specifies Last Year of 5-year range
born_in_mexico <- get_acs(
  geography = "state",
  variables = "B05006_150",
  survey = "acs5", # Use 5-year ACS Data
  year = 2020
)

# Can Also Specify Table

age_table <- get_acs(
  geography = "state",
  table = "B01001",
  year = 2020
)


# Typically can e summarized by county or state
# Available Geometries (Us, Region, Division, State, county, county subdivision, tract, block group, block, "urban area", "combined statistical area", "cbsa", "zcta")

cbsa_population <- get_acs(
  geography = "cbsa",
  variables = "B01003_001",
  year = 2020
)

# Subset by state and county
dane_income <- get_acs(
  geography = "tract",
  variables = "B19013_001",
  state = "WI",
  county = "Dane",
  year = 2020
)


# Accepts state names, postal codes (i.e. MN) or FIPS codes

#get_decennial() # For Decennial Census (2000, 2010, and 2020)
#get_acs() #1yr and 5yr ACS samples. (1-year all the way back to 2005 and 5-yr back to 2005-2009)
usethis::use_data(fullVariableDefns, overwrite = TRUE)

# Check CENSUS API Key Using Below Code
#Sys.getenv("CENSUS_API_KEY")
