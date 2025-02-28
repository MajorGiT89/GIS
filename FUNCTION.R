gis_analysis <- function(taxon_name, taxon_rank = "species") {
  # Load necessary packages
  packs <- c("patchwork","tidyverse","ctv","rinat","sf","rosm","ggspatial","prettymapr", 
             "leaflet", "htmltools", "mapview", "leafpop", "wesanderson","htmlwidgets","htmltools","rmarkdown")
  lapply(packs, require, character.only = TRUE)
  rm(packs)
  
  # Read Vegetation and Soil data
  veg <- st_read("NVM2024Final/Shapefile/NVM2024Final_IEM5_12_07012025.shp")
  soi <- st_read("SOTER_ZA/GIS/SOTER/ZA_SOTERv1.shp")
  soi <- st_transform(soi, st_crs(veg))
  
  # Read in Western Cape polygon and reproject
  WC <- st_read("western-cape-south-africa_1334.geojson")
  WC <- st_transform(WC, st_crs(veg))
  
  # Get iNaturalist Data
  obs_data <- get_inat_obs(taxon_name = taxon_name, bounds = c(-35, 18, -30, 25), maxresults = 10000)
  
  # Filter observations for accuracy and research grade
  filter_data <- function(data) {
    data %>%
      filter(latitude < 0, !is.na(latitude), 
             captive_cultivated == "false", quality_grade == "research")
  }
  
  obs_data <- filter_data(obs_data)
  
  # Convert to spatial objects
  obs_data <- st_as_sf(obs_data, coords = c("longitude", "latitude"), crs = 4326)
  obs_data <- st_transform(obs_data, st_crs(veg)) %>% st_intersection(WC)
  
  # Crop vegetation and soil data to Western Cape
  veg_wc <- st_intersection(veg, WC)
  soi <- st_make_valid(soi)
  soi_wc <- st_intersection(soi, WC)
  
  # Generate mapview with popups
  lpcData <- obs_data %>%
    mutate(click_url = paste("<a href='", obs_data$url, "' target='_blank'>Link to iNat observation</a>", sep = ""))
  
  map <- mapview(obs_data, col.regions = "purple", 
                 legend.title = taxon_name,  
                 popup = popupTable(lpcData, zcol = c("scientific_name","user_login", "click_url")),
                 layer.name = taxon_name) 
  
  # Random colors for Vegetation and Soil Types
  set.seed(123)
  random_colors <- sample(colors(), length(unique(veg_wc$T_Name)))
  veg_typ_wc <- mapview(veg_wc, zcol = "T_Name", color = random_colors, legend = FALSE, layer.name = "Vegetation Type")
  
  set.seed(3000)
  random_colors_soi <- sample(colors(), length(unique(soi$SOIL)))
  soi_typ_wc <- mapview(soi_wc, zcol = "SOIL", color = random_colors_soi, legend = FALSE, layer.name = "Soil Type")
  
  # Combine maps
  combined_map <- map + veg_typ_wc + soi_typ_wc
  comb_edit <- combined_map@map
  
  # Leaflet customization
  comb_edit <- comb_edit %>%
    setView(lng = -31, lat = 21, zoom = 6) %>%
    setMaxBounds(
      lng1 = 17, lat1 = -35,  
      lng2 = 25, lat2 = -30) %>% 
    addTiles(group = "OSM")
  
  # Save map as HTML
  saveWidget(comb_edit, paste0("map_", taxon_name, ".html"))
  
  # Return map object for further use
  return(comb_edit)
}

gis_analysis(taxon_name = "Hydnora africana")
