## Earth at night
capital_cities %>% 
  leaflet() %>%
  addProviderTiles(providers$NASAGIBS.ViirsEarthAtNight2012) %>%
  addCircles(lng = ~capital.longitude,
             lat = ~capital.latitude,
             fillColor = "black",
             radius = 10,
             label = ~paste(Country,",", Capital))

## Shaded relief
capital_cities %>% 
  leaflet() %>%
  addProviderTiles(providers$Esri.WorldShadedRelief) %>%
  addCircles(lng = ~capital.longitude,
             lat = ~capital.latitude,
             fillColor = "black",
             radius = 10,
             label = ~paste(Country,",", Capital))
