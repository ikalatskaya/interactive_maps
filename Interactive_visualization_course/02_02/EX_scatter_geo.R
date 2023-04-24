library("tidyverse")

africa_data_points <- tibble(
  lat = rnorm(26, mean = 6.9, sd = 10),
  lng = rnorm(26, mean = 17.7, sd = 10),
  size = runif(26, 5, 10),
  label = letters
)


# version 1 adding markers
africa_data_points %>% leaflet() %>% addTiles() %>% addMarkers()
# tiles provide the background or the styly of the map.

# version 2
leaflet() %>% addTiles() %>% addMarkers(data = africa_data_points)
# add CircleMarkers
leaflet() %>% addTiles() %>% addCircleMarkers(data = africa_data_points)
leaflet() %>% addTiles() %>% addCircleMarkers(data = africa_data_points, radius = ~size, label = ~paste("Size: ", size, "<br/>",  "Label: ", letters))

capital_cities %>% leaflet() %>% addTiles() %>% addCircleMarkers(lng = ~capital.longitude, lat=~capital.latitude, radius = ~country.population/10^8, popup = ~paste("Country: ", Country, "<br/>", "Capital: ", Capital))
