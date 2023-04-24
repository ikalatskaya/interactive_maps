output$clicked_country <- renderUI({
  if (is.null(input$leaflet_map_shape_click)) {
    fluidRow(column("Map not clicked yet",
                    width = 12))
  } else {
    print(input$leaflet_map_shape_click)
    fluidRow(column("Map clicked", width = 12))
  }
  
})