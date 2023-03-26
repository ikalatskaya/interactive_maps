library(shiny)
library(leaflet)
library(RColorBrewer)
library(shinyWidgets)
library(shinydashboard)
library(shinydashboardPlus)


geoLocation = read.table("data/MA_lat_and_long_updated.txt", sep = "\t", header = TRUE)
all_counties <- readRDS( "data/county_geojson.RDS" ) 

ma_counties = all_counties[all_counties@data$STATE == "25",]
towns = sort(unique(geoLocation$town))

# create the UI
ui <- function() {
  
  shinydashboardPlus::dashboardPage(
    
    header = shinydashboardPlus::dashboardHeader(fixed = TRUE),
    
    sidebar <- shinydashboardPlus::dashboardSidebar(
      id = "sidebar",
      fluidPage(
        # h3("Select town"),
        collapsed = FALSE,
        width = 200,
        shinyWidgets::pickerInput(inputId = "t",
                                  label = h5("Select MA town"), multiple = FALSE,
                                  choices = towns,
                                  selected = "Carlisle",
                                  options = list(`actions-box` = TRUE,
                                                 `count-selected-text` = "Alle",
                                                 liveSearchPlaceholder= TRUE,
                                                 `live-search`=TRUE)),
        br(),
        textOutput("county_info"),
        br()
      )
    ),
    
    
    dashboardBody(
      br(),
      titlePanel("Map of Massachusetts"),
      br(),
      br(),
        fluidRow(
          leaflet::leafletOutput( outputId = "map", height = 850
          )
        )
    ),
    footer = dashboardFooter(left = "Developed by Irina Kalatskaya", right = "2023" )
  )
}
  
  


server <- function(input, output, session) {
  
  
  observe({
    shinyWidgets::updatePickerInput(session, inputId = "t", choices = towns, selected = "Carlisle")
  })
  
  selectedTown <- reactive({
    geoLocation %>% dplyr::filter(town == input$t)
  })
  
  
  output$county_info <- renderText({
    paste("COUNTY: ", selectedTown()$county, sep="\t")
  })
  
  
  bg.map <- shiny::reactive({
    c = selectedTown()$county
    county = ma_counties[ma_counties@data$NAME == c, ]
    
    icons <- awesomeIcons(
      icon = 'ios-close',
      iconColor = 'black',
      library = 'ion'
    )
    selectedTown() %>% leaflet() %>% addTiles() %>% 
      addAwesomeMarkers(label = ~town, icon=icons, lng = ~longitude, lat = ~latitude) %>% 
      setView(lng = -71.0589, lat = 42.3601, zoom = 8) %>% 
      addPolygons( data = county, fillOpacity = 0, opacity = 0.4, color = "#000000",
                   weight = 3, layerId = county$CENSUSAREA, 
                   popup = county$NAME,
                   group = "click.me"
      )
    
  })

  
  output$map <- renderLeaflet({
    bg.map()
  })
  
}

shinyApp(ui = ui, server = server)


