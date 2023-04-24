library("geosphere")
library("sf")
library("leaflet")

work_place_route_curved <- gcIntermediate(
  c(-1.2599604, 51.7567909),
  c(-119.5155058, 34.3869745),
  n = 50,
  sp = TRUE,
  addStartEnd = TRUE
)

work_placed_route_straight <-
  st_sfc(st_linestring(matrix(
    c(-1.2599604,-119.5155058, 51.7567909, 34.3869745),
    nrow = 2,
    ncol = 2
  )))


leaflet() %>%
  addTiles() %>%
  addPolylines(data = work_placed_route_straight) %>%
  addPolylines(data = work_place_route_curved)
