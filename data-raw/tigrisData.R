## code to prepare `tigrisData` dataset goes here
library(tigris)
library(ggplot2)
library(tidycensus) # Package Guide Here: https://walker-data.com/census-r/an-introduction-to-tidycensus.html
library(sf)


#### US States -------------
fipsCodes <- data.table::data.table(tidycensus::fips_codes)[
  !(state_name %in% c("American Samoa",
                      "Guam",
                      "Northern Mariana Islands",
                      "Puerto Rico",
                      "U.S. Minor Outlying Islands",
                      "U.S. Virgin Islands"))]

usethis::use_data(fipsCodes, overwrite = TRUE) # Export Data to /data folder


#### US Counties -------------
usCounties_2020 <- tigris::counties(state = unique(fipsCodes$state_name),
                                    cb = TRUE,
                                    resolution = "5m",
                                    year = 2020)%>%sf::st_transform(crs = 4326)

usethis::use_data(usCounties_2020, overwrite = TRUE) # Export Data to /data folder

# usWater <- tigris::area_water(year = 2020)
#
# library(tigris)
# # Key Geogs
# #
# cbsa_metro <- tigris::core_based_statistical_areas(
#   resolution = "20m",
#   year = 2020
# )
#
# test <- cbsa_metro[cbsa_metro$MEMI == "1",]
#
# plot(test$geometry)
#
# class(cbsa_metro)
# cbsa_metro$MEMI
# test <- cbsa_metro%>%filter(cbsa_metro, MEMI == "1")
# reg <- tigris::regions()
# plot(cbsa$geometry)
# tigris::list_counties("MN")$
# ramsey_water <- area_water("MN", "Ramsey")
# ramsey_linear_water<- linear_water("MN", "Ramsey")
#
#
# mn_water <- area_water("MN", tigris::list_counties("MN")$county_code) #30 Seconds Per State
# primaryRoads <- tigris::primary_roads(year = 2020)
#
# plot(mn_water$geometry)
# plot(primaryRoads$geometry)
#
# object.size(mn_water)/1073741824 # 0.1 GB
#
# st <- tigris::states(cb = TRUE, resolution = "20m") # 2 Seconds cb = TRUE ensures boundaries match cartographic boundary
# # Resolution can be 500k, 5m, or 20m: Higher Values represent more generalized boundaries (20m is most generalized)
#
# us_states_shifted <- shift_geometry(st)
#
# # Seconds
# ggplot(us_states_shifted) +
#   geom_sf() +
#   labs(title = "  Median Age by State, 2019",
#        caption = "Data source: 2019 1-year ACS, US Census Bureau",
#        fill = "ACS estimate") +
#   theme_void()
#
# usethis::use_data(geogData, overwrite = TRUE)
