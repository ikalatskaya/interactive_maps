library(tidyverse)
library(sf)
library(leaflet)
library(geojsonio)
library(RColorBrewer)
library(glue)
library(oidnChaRts)

states <- geojsonio::geojson_read("https://rstudio.github.io/leaflet/json/us-states.geojson", what = "sp")
nb.cols = 15
mycolors = colorRampPalette(brewer.pal(8, "Set2"))(nb.cols)

shinyServer(function(input, output, session) {
  output$highlight_countries_UI <- renderUI({
    selectInput(
      "state_to_show",
      "SHOW STATES",
      choices = unique(states$name),
      multiple = TRUE,
      width = "100%"
    )
    
  })
  
  output$clicked_country <- renderUI({
    if (is.null(input$leaflet_map_shape_click)) {
      fluidRow(column("Map not clicked yet", width = 12))
    } 
    else {
      fluidRow(column(
        paste0("Selected STATES: ", input$leaflet_map_shape_click$id),
        width = 12
      ),
      column(
        paste0(
          "Click coordinates: ",
          input$leaflet_map_shape_click$lat,
          ",",
          input$leaflet_map_shape_click$lng
        ),
        width = 12
      ))
    }
    
  })
  
  output$leaflet_map <- renderLeaflet({
    
    m <-  leaflet(as.data.frame(states)) %>% setView(-72.015193, 42.414006,  zoom = 8)
    m %>% addPolygons(opacity = 0.3, fillColor = mycolors[1], fill = TRUE, weight = 3, layerId = ~name, color = mycolors[5]) %>% addTiles()
    
    #data_world_shapefiles %>%
    #  leaflet() %>%
    #  addTiles() %>%
    #  addPolygons(label = ~ name,
    #              weight = 1,
    #              layerId = ~ name)
    
  })
  
 # observeEvent(input$state_to_show, {
 #   leafletProxy("leaflet_map", session) %>% addPolygons(lat= input$leaflet_map_shape_click$lat, lng = input$leaflet_map_shape_click$long)
    
 # })
  
})