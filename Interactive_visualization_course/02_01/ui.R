library("leaflet")

shinyUI(
  fluidPage(
    uiOutput("highlight_countries_UI"),
    br(),
    uiOutput("clicked_country"),
    br(),
    leafletOutput("leaflet_map")
  )
)