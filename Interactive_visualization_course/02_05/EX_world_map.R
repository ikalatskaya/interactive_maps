library("sf")
library("gapminder")
library("tidyverse")
library("leaflet")

world_shapefiles <- read_sf(dsn = "Interactive_visualization_course/02_05/data-raw/world-shape-files/")

gapminder_most_recent <- gapminder %>%
  mutate_if(is.factor, as.character) %>%
  filter(year == max(year)) %>%
  select(-continent, -year) %>%
  rename(name = country)

gapminder_world <- world_shapefiles %>%
  left_join(gapminder_most_recent)

# outliners of all countries
gapminder_world %>% leaflet() %>% addPolygons(weight = 1, label = ~name, popup = ~paste("Country: ", name, "<br/>", pop))


##########################################
### COLOUR BY CONTINENT:
##########################################

# from here https://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3
continent_palette = colorFactor("Dark2", unique(gapminder_world$continent))



# outliners of all countries
gapminder_world %>% leaflet() %>% addPolygons(weight = 1, 
                                              color = ~continent_palette(continent),
                                              label = ~name, 
                                              popup = ~paste("Country: ", name, "<br/>", pop))



##########################################
####### COLOUR by life expectance
##########################################

lifeExp_quantile_palette = colorQuantile("YlOrRd", gapminder_world$lifeExp)

lifeExp_bin_palette = colorBin("YlOrRd", domain = gapminder_world$lifeExp)

#ffffcc
#ffeda0
#fed976
#feb24c
#fd8d3c
#fc4e2a
#e31a1c
#b10026

# outliners of all countries
gapminder_world %>% leaflet() %>% addPolygons(weight = 1, 
                                              color = ~lifeExp_quantile_palette(lifeExp),
                                              label = ~name, 
                                              popup = ~paste("Country: ", name, "<br/>", lifeExp))


# outliners of all countries
gapminder_world %>% leaflet() %>% addPolygons(weight = 1, 
                                              color = ~lifeExp_bin_palette(lifeExp),
                                              label = ~name, 
                                              popup = ~paste("Country: ", name, "<br/>", lifeExp))




