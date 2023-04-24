library("sf")

world_shapefiles <- read_sf(dsn = "data-raw/world-shape-files/")
ma_shapefiles <- read_sf(dsn = "~/Downloads/townssurvey_shp/")

class(ma_shapefiles)
class(world_shapefiles)

library("gapminder")
library("tidyverse")

gapminder_most_recent <- gapminder %>%
  mutate_if(is.factor, as.character) %>%
  filter(year == max(year)) %>%
  select(-continent, -year) %>%
  rename(name = country)

gapminder_world <- world_shapefiles %>%
  left_join(gapminder_most_recent)

gapminder_world %>%
  select(name, lifeExp)
