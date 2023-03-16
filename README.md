# Interactive maps for Rshiny

Collection of codes and hints on how to incorporate interactive maps into Rshiny

GeoJSON is an open standard format designed for representing simple geographical features, along with their non-spatial attributes, based on JavaScript Object Notation.

### Load libraries

    library(leaflet)
    library(dplyr)

### Show towns and cities in MA

To show location of the town on the map, we will need its latitude and longitude. I found one \<a href="<https://www.mapsofworld.com/usa/states/massachusetts/lat-long.html>" here </a> for Massachusetts towns and cities.

    index = read.table("data/MA_lat_and_long.txt", sep = "\t")
    index %>% leaflet() %>% addTiles() %>% addMarkers(label = ~Location) %>% setView(lng = -71.0589, lat = 42.3601, zoom = 8)

![](images/Screenshot%202023-03-15%20at%206.57.02%20PM.png){width="434"}

To cluster markers together for better visualization:

    index %>% leaflet() %>% addTiles() %>% addCircleMarkers(label = ~Location,clusterOptions = markerClusterOptions()) %>% setView(lng = -71.0589, lat = 42.3601, zoom = 8)

![](images/Screenshot%202023-03-15%20at%207.06.50%20PM.png)

### States and counties

The geojson files for US states and counties could be downloaded from \<a href="<https://eric.clst.org/tech/usgeojson/>" here </a> that was put together by Eric Celeste. These files are available in various resolutions and are all derived from the 2010 census.

    geofile_county = "data/gz_2010_us_050_00_500k.json"

    # Load geojson files and transform vector into spatial dataframe
    ma_towns_spacial <- rgdal::readOGR( dsn = geofile_towns, stringsAsFactors = FALSE)


    leaflet() %>% addTiles( urlTemplate = "https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png") %>%
          setView(-72.015193, 42.414006,  zoom = 8) %>%
          addPolygons( data = ma_towns_spacial,
                       fillOpacity = 0,
                       opacity = 0.3,
                       color = "#000000",
                        weight = 3,
                       layerId = ma_towns_spacial$TOWN
          )

![](images/Screenshot%202023-03-16%20at%207.27.52%20AM.png)
