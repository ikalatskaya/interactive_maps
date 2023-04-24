library("tidyverse")
library("leaflet")
library("sf")
library("geosphere")
library(sp)

geolines_data <- read_csv("Interactive_visualization_course/02_06/data/geolines-data.csv")

geolines_data %>% View()

start_locs = geolines_data %>% select(start.longitude, start.latitude)
end_locs = geolines_data %>% select(end.longitude, end.latitude)

the_great_circles = gcIntermediate(
  p1 =start_locs,
  p2 = end_locs,
  n = 50,
  addStartEnd = TRUE,
  sp = TRUE
  
)

class(the_great_circles)

the_great_circles <- SpacialLinesDataFrame(
  the_great_circles,
  data = geolines_data
  
)

class(the_great_circles)

the_great_circles <- st_as_sf(the_great_circles)

leaflet() %>% 
  addTiles() %>%
  addPolylines(data = the_great_circles, weight = 2, label = ~paste("Start: ", start.location, "End", end.location)) %>% 
  addCircleMarkers(data= end_locs, 
                   lat = ~end.latitude,
                   lng = ~end.longitude,
                   color = "red",
                   radius = 2)
