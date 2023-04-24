library("leaflet")

shinyUI(
  fluidPage(
    uiOutput("highlight_countries_UI"),
    leafletOutput("leaflet_map")
  )
)