library("tidyverse")
library("oidnChaRts")
library("sf")
library("leaflet")


shinyServer(function(input, output, session) {
  output$highlight_countries_UI <- renderUI({
    selectInput(
      "countries_to_remove",
      "Remove countries",
      choices = unique(data_world_shapefiles$name),
      multiple = TRUE,
      width = "100%"
    )
    
  })
  
  output$leaflet_map <- renderLeaflet({
    data_world_shapefiles %>%
      leaflet() %>%
      addTiles() %>%
      addPolygons(label = ~ name,
                  weight = 1,
                  layerId = ~ name)
    
  })
  
})