library("oidnChaRts")
library("leaflet")
library("sf")

## Scatter Geo Markers
data_geo_marker_plot %>%
  leaflet() %>%
  addTiles() %>%
  addMarkers(label = ~city)

## Scatter Geo Plots
data_geo_marker_plot %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(radius = ~count/8,
                   label = ~city)

## Clustered Scatter Geo Plots
data_geo_marker_plot %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(radius = ~count/8,
                   label = ~city,
                   clusterOptions = markerClusterOptions())

## Choropleth
choropleth_colorPal <- colorFactor("Set2", unique(data_world_shapefiles$continent))
data_world_shapefiles %>%
  leaflet() %>%
  addTiles() %>%
  addPolygons(color = ~choropleth_colorPal(continent),
              label = ~name,
              weight = 1) %>%
  addLegend(colors = RColorBrewer::brewer.pal(length(unique(data_world_shapefiles$continent)), "Set2"),
            labels = unique(data_world_shapefiles$continent))

