# Interactive Maps for RShiny and Rmarkdown

Collection of codes and hints on how to incorporate interactive maps into Rshiny.

Leaflet is the leading open-source JavaScript-based library for mobile-friendly interactive maps: [`https://leafletjs.com/.`](https://leafletjs.com/%22)

It was explicitly designed for plotting geographical features. Leaflet and leaflet.js libraries are free to use without restrictions.

## Map markers

### Install and load libraries

    library(leaflet)
    library(dplyr)
    library(sf)
    library(geojsonio)

### Show towns and cities in MA using scatter geomarker plots

To show location of the town on the map, we will need its latitude and longitude. I found this information over here: <https://www.mapsofworld.com/usa/states/massachusetts/lat-long.html>" for Massachusetts towns and cities.

    geolocation_ma_towns = read.table("data/MA_lat_and_long_updated.txt", sep = "\t", header = TRUE)

    geolocation_ma_towns %>% na.omit() %>% leaflet() %>% addTiles() %>% addMarkers(label = ~town, lat = ~latitude, lng = ~longitude) %>% setView(lng = -71.0589, lat = 42.3601, zoom = 8)

![](images/Screenshot%202023-03-15%20at%206.57.02%20PM.png "Towns and cities in MA"){width="434"}

To cluster markers together for better visualization:

    geolocation_ma_towns %>% na.omit() %>% leaflet() %>% addTiles() %>% addCircleMarkers(label = ~town, lat = ~latitude, lng = ~longitude, radius = 8, clusterOptions = markerClusterOptions()) %>% setView(lng = -71.0589, lat = 42.3601, zoom = 8)

![](images/Screenshot%202023-03-15%20at%207.06.50%20PM.png){width="434"}

We can cluster together the markers and as we zoom in, we can see markers break apart.

### Maps and backgrounds

A really cool collection of maps that could be used as a background (on several languages) features different geographical features could be found here:

<http://leaflet-extras.github.io/leaflet-providers/preview/index.html>

And added to leaflet through the following function:

\`\` %\>% `addProviderTiles(providers$OpenTopoMap)`\`\`

## Map shapes

### Obtaining JSON and ESRI shapefiles

GeoJSON is an open standard format designed for representing simple geographical features, along with their non-spatial attributes, based on JavaScript Object Notation.

<https://www.naturalearthdata.com/downloads/>

<https://github.com/johan/world.geo.json/tree/master/countries>

### Importing GeoJSON and ESRI shapefiles

Import shape files with library(sf).

ESRI must contain at least the dbf, the shp and the shx files.

    df <- read_sf(dsn = "path_to_folder_with_ESRI_files")

Or, as an option, shape data could be read geojson or other formats from a local file or a URL. Data will be stored as sp object.

    states <- geojsonio::geojson_read("https://rstudio.github.io/leaflet/json/us-states.geojson", what = "sp")


    leaflet() %>% addTiles() %>%
         setView(-72.015193, 42.414006,  zoom = 8) %>%
         addPolygons( data = states,
                      fillOpacity = 0,
                      opacity = 0.3,
                      color = "#000000",
                      weight = 3,
                      layerId = states$name
         )

![](images/Screenshot%202023-03-26%20at%209.54.24%20PM.png){width="434"}

There is a way to parse sp object and cut only the shape of the specific state:


    temp = states[states@data$id == 25,]

    leaflet() %>% addTiles() %>%
         setView(-72.015193, 42.414006,  zoom = 8) %>%
         addPolygons( data = temp,
                      fillOpacity = 0,
                      opacity = 0.3,
                      color = "#000000",
                      weight = 3,
                      layerId = temp$name
         )

![](images/Screenshot%202023-03-26%20at%209.57.47%20PM.png){width="434"}

### States and counties

The geojson files for US states and counties could be downloaded from \<a href="<https://eric.clst.org/tech/usgeojson/>" here </a> that was put together by Eric Celeste. These files are available in various resolutions and are all derived from the 2010 census.

    geofile_county = "data/gz_2010_us_050_00_500k.json"

    # Load geojson files and transform vector into spatial dataframe
    ma_towns_spacial <- rgdal::readOGR( dsn = geofile_county, stringsAsFactors = FALSE)


    leaflet() %>% addTiles( urlTemplate = "https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png") %>%
          setView(-72.015193, 42.414006,  zoom = 8) %>%
          addPolygons( data = ma_towns_spacial,
                       fillOpacity = 0,
                       opacity = 0.3,
                       color = "#000000",
                        weight = 3,
                       layerId = ma_towns_spacial$TOWN
          )

![](images/Screenshot%202023-03-16%20at%207.27.52%20AM.png){width="434"}

    ```

    index %>% na.omit() %>% leaflet() %>% addTiles() %>% addProviderTiles(providers$NASAGIBS.ViirsEarthAtNight2012) %>% addCircleMarkers(label = ~town
    ,clusterOptions = markerClusterOptions()) %>% setView(lng = -71.0589, lat = 42.3601, zoom = 8)


    ```

### Choropleth map

Choropleth map is map that uses differences in shading or coloring within predefined areas to indicate the average values of a property or quantity in those areas.

### Rshiny apps

1.  towns_in_MA.R

    Shows how to mark MA towns based on the user's selection:

![](images/Screenshot%202023-03-26%20at%2010.05.05%20PM.png){width="434"}

2.  clickable_map_ma_county.R

    ![](images/Screenshot%202023-03-26%20at%2010.07.17%20PM.png){width="434"}

### Other interesting resources:

Distance calculation between two towns:

<https://simplemaps.com/resources/location-distance>
