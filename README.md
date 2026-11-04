# GIS
Global Gender Inequality Index Change (2010–2019)

Project Overview

This project examines changes in the Gender Inequality Index (GII) across countries between 2010 and 2019. The aim is to combine global gender inequality data with world spatial data and create a GeoJSON dataset for spatial analysis.

Data Sources

Gender Inequality Index: United Nations Development Programme (UNDP), Human Development Report, All Composite Indices and Components Time Series (1990–2023).

World Boundaries: GeoJSON world country boundaries from the geo-countries GitHub repository.

Methodology

Imported the global GII dataset into R.

Calculated the change in GII between 2010 and 2019:

GII Change = GII (2019) − GII (2010)

Joined the GII data to world spatial data using ISO3 country codes.

Checked unmatched country codes and missing values.

Exported the resulting spatial dataset as GeoJSON.

A negative change indicates a reduction in gender inequality, while a positive change indicates an increase.

Results

The final GeoJSON dataset contains 258 geographic features, of which 154 have valid GII change values and 104 have missing values.

Of the 104 missing values, 63 correspond to unmatched country codes, while the remaining 41 correspond to matched records without valid GII change values.

Missing values were retained rather than replaced with estimated values.

Repository Files

01_data_preparation.R — R script for data processing and spatial joining.

HDR25_Composite_indices_complete_time_series.csv — Original UNDP dataset.

world.geojson — Original world spatial data.

world_gii_change_2010_2019.geojson — Final spatial dataset containing GII changes.

Tools

R, RStudio, sf, dplyr, countrycode, GitHub.
