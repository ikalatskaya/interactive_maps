library("tidyverse")
library("leaflet")

capital_cities <- read_csv("Interactive_visualization_course/02_03/data/capitals_with_locations.csv")

# Additional map tiles: http://leaflet-extras.github.io/leaflet-providers/preview/index.html

## Visualization of Sherbrooke area in QC
capital_cities %>% 
leaflet() %>%
  addTiles() %>% addProviderTiles(providers$OpenTopoMap) %>% setView(lng =-72.1480, lat =  45.2665, zoom = 8)
  addMarkers(lng = ~capital.longitude,
             lat = ~capital.latitude)
