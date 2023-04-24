# Obtained maps from http://www.naturalearthdata.com/downloads/50m-cultural-vectors/
download.file(
  url = "https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
  destfile = "interactive_visualization_course/02-04/data-raw/world-shape-files_v2.zip")



unzip("data-raw/world-shape-files.zip", 
      exdir = "interactive_visualization_course/02-04/data-raw/world-shape-files")
