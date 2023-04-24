## example from http://rpubs.com/bhaskarvk/tilegramsR
library("leaflet") 
library("tilegramsR")
library("colormap")

states <- FiveThirtyEightElectoralCollege.states@data$state
factpal <- colorFactor(colormap(
  nshades = length(states)), states)


leaflet(
  options=leafletOptions(
    crs = leafletCRS("L.CRS.Simple"),
    minZoom = -1.5, maxZoom = -1.5,
    dragging = FALSE, zoomControl = FALSE,
    attributionControl = FALSE)) %>%
  addPolygons(
    data=FiveThirtyEightElectoralCollege,
    weight=1,color='#000000', fillOpacity = 0.5, opacity=0.2,
    fillColor= ~factpal(state)) %>%
  addPolygons(
    data=FiveThirtyEightElectoralCollege.states, group = 'states',
    weight=2,color='#000000',
    fill = T, opacity = 1, fillOpacity = 0,
    highlightOptions = highlightOptions(weight = 4)) %>%
  addLabelOnlyMarkers(
    data=FiveThirtyEightElectoralCollege.centers,
    label = ~as.character(state),
    labelOptions = labelOptions(
      noHide = 'T', textOnly = T,
      offset=c(-8,-20), textsize = '15px'))
