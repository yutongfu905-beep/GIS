
# 1. Load required packages
library(sf)
library(dplyr)
library(countrycode)

# 2. Import global gender inequality data
gii_data <- read.csv(
  "HDR25_Composite_indices_complete_time_series.csv",
  fileEncoding = "latin1"
)

# 3. Calculate the change in GII
# Negative values indicate reduced inequality
# Positive values indicate increased inequality

gii_data$gii_change <- gii_data$gii_2019 -
  gii_data$gii_2010

# 4. Read world spatial data
world <- st_read("world.geojson")

# 5. Join GII data to world spatial data
# Match countries using ISO3 codes

world_gii <- world %>%
  left_join(
    gii_data,
    by = c("ISO3166.1.Alpha.3" = "iso3")
  )

# 6. Check missing values
nrow(world_gii)
sum(!is.na(world_gii$gii_change))
sum(is.na(world_gii$gii_change))

# 7. Identify unmatched country codes
unmatched <- world %>%
  filter(
    !ISO3166.1.Alpha.3 %in% gii_data$iso3
  ) %>%
  st_drop_geometry() %>%
  select(name, ISO3166.1.Alpha.3)

# 8. Create final spatial dataset
world_gii_final <- world_gii %>%
  transmute(
    name = name,
    iso3 = ISO3166.1.Alpha.3,
    gii_2010 = gii_2010,
    gii_2019 = gii_2019,
    gii_change = gii_change
  )

# 9. Export final GeoJSON file
st_write(
  world_gii_final,
  "world_gii_change_2010_2019.geojson",
  delete_dsn = TRUE
)

# 10. Verify exported data
test_map <- st_read(
  "world_gii_change_2010_2019.geojson"
)

nrow(test_map)
names(test_map)