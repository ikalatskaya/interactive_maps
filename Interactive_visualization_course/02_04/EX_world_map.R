library("sf")
library("gapminder")
library("tidyverse")
library("leaflet")

# Obtained maps from http://www.naturalearthdata.com/downloads/50m-cultural-vectors/
download.file(
  url = "http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
  destfile = "data-raw/world-shape-files.zip")

# unzip("data-raw/world-shape-files.zip", exdir = "data-raw/world-shape-files")


### class sf
world_shapefiles <- read_sf(dsn = "Interactive_visualization_course/02_04/data-raw/world-shape-files/")


gapminder_most_recent <- gapminder %>%
  mutate_if(is.factor, as.character) %>%
  filter(year == max(year)) %>%
  select(-continent, -year) %>%
  rename(name = country)

## join sp with normal df
gapminder_world <- world_shapefiles %>%
  left_join(gapminder_most_recent)


qpal <- colorNumeric("Blues", gapminder_world$lifeExp, na.color = "#808080")

gapminder_world %>%
  leaflet() %>%
  addTiles() %>%
  addPolygons(
    stroke = FALSE,
    smoothFactor = 0.2,
    fillOpacity = 1,
    color = ~qpal(lifeExp),
    label = ~name,
    label = ~name,
    popup = ~ paste("Country:", name, "<br/>", "Life Expectancy:", lifeExp)
  ) %>%
  addLegend(pal = qpal, values = ~lifeExp, opacity = 1,
            title = paste0("Life Expectancy <br/>(Gapminder in ",max(gapminder$year, na.rm = TRUE), ")"))
