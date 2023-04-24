library("sf")
library("gapminder")
library("tidyverse")
library("leaflet")

world_shapefiles <- read_sf(dsn = "data-raw/world-shape-files/")

gapminder_most_recent <- gapminder %>%
  mutate_if(is.factor, as.character) %>%
  filter(year == max(year)) %>%
  select(-continent, -year) %>%
  rename(name = country)

gapminder_world <- world_shapefiles %>%
  left_join(gapminder_most_recent)

continent_palette <- colorFactor("Dark2", unique(gapminder_world$continent))

gapminder_world %>%
  leaflet() %>%
  addPolygons(weight = 1,
              label = ~name,
              popup = ~paste("Country", name, "<br/>", pop),
              color = ~continent_palette(continent))
