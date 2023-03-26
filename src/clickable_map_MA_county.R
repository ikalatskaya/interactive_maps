# Adopted from:
# https://stackoverflow.com/questions/48432061/turn-states-on-a-map-into-clickable-objects-in-shiny

# this app shows a clickable map of Massachussech.
# Counties could be selected one-by-one ar several at the same time.

library(leaflet)    
library(shiny)
library(shinydashboard)

ma_counties <- readRDS("data/county_geojson.RDS") 


ui <- fluidPage(
  shinydashboard::box(
    width = 12,
      title = "Click on the map!",
      column(
      width = 2,
         shiny::actionButton( inputId = "clearHighlight",
                              icon = icon( name = "eraser"),
                              label = "Clear the Map",
                              style = "color: #fff; background-color: #D75453; border-color: #C73232"
      )
    ), column( width = 10, leaflet::leafletOutput( outputId = "myMap", height = 850  ))
  ) 
)



server <- function( input, output, session ){
  
  bg.map <- shiny::reactive({
    leaflet() %>%
      addTiles( urlTemplate = "https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png") %>%
      setView(-72.015193, 42.414006,  zoom = 8) %>%
      addPolygons( data = ma_counties,
                     fillOpacity = 0.1,
                   opacity = 0.2,
                   color = "#000000",
                   weight = 2,
                   layerId = ma_counties$CENSUSAREA,
                   popup = ma_counties$NAME,
                   group = "click.list"
      )
  })
  
  output$myMap <- renderLeaflet({
    bg.map()
  })
  
  click.list <- shiny::reactiveValues( ids = vector() )
  
  # observe where the user clicks on the leaflet map
  # during the Shiny app session
  # Courtesy of two articles:
  # https://stackoverflow.com/questions/45953741/select-and-deselect-polylines-in-shiny-leaflet
  # https://rstudio.github.io/leaflet/shiny.html
  shiny::observeEvent( input$myMap_shape_click, {
    
    # store the click(s) over time
    click <- input$myMap_shape_click
    
    # store the polygon ids which are being clicked
    click.list$ids <- c( click.list$ids, click$id )
    
    # filter the spatial data frame
    # by only including polygons
    # which are stored in the click.list$ids object
    lines.of.interest <- ma_counties[ which( ma_counties$CENSUSAREA %in% click.list$ids ) , ]
    
    # if statement
    if( is.null( click$id ) ){
      # check for required values, if true, then the issue
      # is "silent". See more at: ?req
      req( click$id )
      
    } else if( !click$id %in% lines.of.interest@data$id ){
      
      # call the leaflet proxy
      leaflet::leafletProxy( mapId = "myMap" ) %>%
        # and add the polygon lines
        # using the data stored from the lines.of.interest object
        addPolylines( data = lines.of.interest
                      , layerId = lines.of.interest@data$id
                      , color = "#6cb5bc"
                      , weight = 5
                      , opacity = 1
        ) 
    } # end of if else statement
  }) # end of shiny::observeEvent({})
  
  
  
  
  # Create the logic for the "Clear the map" action button
  # which will clear the map of all user-created highlights
  # and display a clean version of the leaflet map
  shiny::observeEvent( input$clearHighlight, {
    # recreate $myMap
    output$myMap <- leaflet::renderLeaflet({
      # set the reactive value of click.list$ids to NULL
      click.list$ids <- NULL
      # recall the foundational.map() object
      foundational.map()
    }) # end of re-rendering $myMap
  }) # end of clearHighlight action button logic
  
} # end of server

shiny::shinyApp( ui = ui, server = server)
