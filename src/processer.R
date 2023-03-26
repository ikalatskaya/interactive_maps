# https://github.com/cenuno/shiny/blob/master/cps_locator/Data/raw-data/rawData.R
# install.packages( "rgdal" )
# Map of Boston
# Irina Kalatskaya
# March 10th, 2023

library(rgdal)
library(geojsonR)
#geojson_comarea_url = "https://gis.boston.gov/arcgis/rest/services/Planning/OpenData/MapServer/9/query?where=1%3D1&outFields=*&outSR=4326"
#file_js = FROM_GeoJson(url_file_string = geojson_comarea_url)

# downloaded from https://eric.clst.org/tech/usgeojson/

geofile_county = "data/gz_2010_us_050_00_500k.json"
# transform vector into spatial dataframe
MA_country_geojson <- rgdal::readOGR( dsn = geofile_county, stringsAsFactors = FALSE)
saveRDS( object = MA_country_geojson, file = "data/county_geojson.RDS")
