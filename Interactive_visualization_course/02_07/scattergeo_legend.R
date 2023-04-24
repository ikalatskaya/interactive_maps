library("tidyverse")
library("leaflet")

capital_cities <- read_csv("data/capitals_with_locations.csv")

capital_cities %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(lng = ~capital.longitude,
             lat = ~capital.latitude)