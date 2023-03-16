# Interactive maps for Rshiny

Collection of codes and hints on how to incorporate interactive maps into Rshiny

GeoJSON is an open standard format designed for representing simple geographical features, along with their non-spatial attributes, based on JavaScript Object Notation.

### States and counties

The geojson files for US states and counties could be downloaded from <a href="https://eric.clst.org/tech/usgeojson/"> here </a> that was put together by Eric Celeste. These files are available in various resolutions and are all derived from the 2010 census.

### Load libraries

    library(leaflet)
    library(dplyr)

### Show towns and cities in MA

Download To show location of the town on the map, we will need its latitude and longitude. I found one <a href="https://www.mapsofworld.com/usa/states/massachusetts/lat-long.html"> here </a> for Massachusetts towns and cities.

    index = read.table("data/MA_lat_and_long.txt", sep = "\t")
    index %>% leaflet() %>% addTiles() %>% addMarkers(label = ~Location) %>% setView(lng = -71.0589, lat = 42.3601, zoom = 8)

![](images/Screenshot%202023-03-15%20at%206.57.02%20PM.png){width="434"}

To cluster markers together for better visualization:


    index %>% leaflet() %>% addTiles() %>% addCircleMarkers(label = ~Location,clusterOptions = markerClusterOptions()) %>% setView(lng = -71.0589, lat = 42.3601, zoom = 8)

![](images/Screenshot%202023-03-15%20at%207.06.50%20PM.png)

### Load geojson files

    geofile_county = "data/gz_2010_us_050_00_500k.json"

    map <- leaflet(states) %>% setView(lng = -71.0589, lat = 42.3601, zoom = 8) %>%
      setView(-96, 37.8, 4) %>% # map Boston
        addProviderTiles("MapBox", options = providerTileOptions(id = "mapbox.light",
          #  accessToken = Sys.getenv('MAPBOX_ACCESS_TOKEN')))
        m %>% addPolygons(opacity = 0.3, fillColor = mycolors[1], fill = TRUE, weight = 4, color = mycolors[5]) %>% addTiles()

    leaflet() %>%
          addTiles( urlTemplate = "https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png") %>%
          setView(-72.015193, 42.414006,  zoom = 8) %>%
          addPolygons( data = comarea606
                       , fillOpacity = 0
                       , opacity = 0.2
                       , color = "#000000"
                       , weight = 2
                       , layerId = comarea606$CENSUSAREA
                       , group = "click.list"
          )
