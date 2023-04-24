observeEvent(input$countries_to_remove, {
  
  leafletProxy("leaflet_map", session) %>%
    removeShape(input$countries_to_remove)
  
})