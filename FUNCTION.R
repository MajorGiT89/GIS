gis_analysis <- function(taxon_names) {
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
  
  # Assign colors for each taxon
  taxon_colors <- setNames(sample(colors(), length(taxon_names)), taxon_names)
  
  # Function to get and process iNaturalist data
  get_processed_inat_data <- function(taxon_name) {
    obs_data <- get_inat_obs(taxon_name = taxon_name, bounds = c(-35, 18, -30, 25), maxresults = 10000) %>%
      filter(latitude < 0, !is.na(latitude), 
             captive_cultivated == "false", quality_grade == "research") %>%
      st_as_sf(coords = c("longitude", "latitude"), crs = 4326) %>%
      st_transform(st_crs(veg)) %>%
      st_intersection(WC)
    return(obs_data)
  }
  
  # Get observations for each taxon
  obs_list <- lapply(taxon_names, get_processed_inat_data)
  names(obs_list) <- taxon_names
  
  # Crop vegetation and soil data to Western Cape
  veg_wc <- st_intersection(veg, WC)
  soi <- st_make_valid(soi)
  soi_wc <- st_intersection(soi, WC)
  
  # Generate mapview with popups, unique colors, and buffers
  map_layers <- list()
  buffer_1km_layers <- list()
  buffer_10km_layers <- list()
  
  for (taxon in taxon_names) {
    obs_data <- obs_list[[taxon]] %>%
      mutate(click_url = paste("<a href='", url, "' target='_blank'>Link to iNat observation</a>", sep = ""))
    
    map_layers[[taxon]] <- mapview(obs_data, col.regions = taxon_colors[[taxon]], 
                                   legend.title = taxon,  
                                   popup = popupTable(obs_data, zcol = c("scientific_name","user_login", "click_url")),
                                   layer.name = taxon)
    
    buffer_1km <- st_buffer(obs_data, dist = 1000)
    buffer_10km <- st_buffer(obs_data, dist = 10000)
    
    buffer_1km_layers[[taxon]] <- mapview(buffer_1km, col.regions = taxon_colors[[taxon]], alpha = 0.3, layer.name = paste(taxon, "1km Buffer"))
    buffer_10km_layers[[taxon]] <- mapview(buffer_10km, col.regions = taxon_colors[[taxon]], alpha = 0.2, layer.name = paste(taxon, "10km Buffer"))
  }
  
  # Random colors for Vegetation and Soil Types
  set.seed(123)
  veg_typ_wc <- mapview(veg_wc, zcol = "T_Name", color = sample(colors(), length(unique(veg_wc$T_Name))), 
                        legend = FALSE, layer.name = "Vegetation Type")
  
  set.seed(3000)
  soi_typ_wc <- mapview(soi_wc, zcol = "SOIL", color = sample(colors(), length(unique(soi$SOIL))), 
                        legend = FALSE, layer.name = "Soil Type")
  
  # Combine maps
  combined_map <- Reduce(`+`, map_layers) + Reduce(`+`, buffer_1km_layers) + Reduce(`+`, buffer_10km_layers) + veg_typ_wc + soi_typ_wc
  comb_edit <- combined_map@map
  
  # Leaflet customization
  comb_edit <- comb_edit %>%
    setView(lng = -31, lat = 21, zoom = 6) %>%
    setMaxBounds(lng1 = 17, lat1 = -35, lng2 = 25, lat2 = -30) %>% 
    addTiles(group = "OSM") %>%
    addControl(
      html = "<style>
                .leaflet-bar-part[title*='Zoom'] { display: none !important; }
                .state-Zoom.buffer-active { display: none !important; }
              </style>", 
      position = "topleft", 
      className = "custom-css"
    )
  
  # Summarizing Points by Vegetation Type
  summary_by_veg <- list()
  for (taxon in taxon_names) {
    points_with_veg <- st_join(obs_list[[taxon]], veg_wc)
    summary_by_veg[[taxon]] <- points_with_veg %>%
      group_by(T_Name) %>%
      summarise(count = n(), 
                avg_x = mean(st_coordinates(points_with_veg)[, 1]), 
                avg_y = mean(st_coordinates(points_with_veg)[, 2]))
  }
  
  # Summarizing Points by Soil Type
  summary_by_soil <- list()
  for (taxon in taxon_names) {
    points_with_soil <- st_join(obs_list[[taxon]], soi_wc)
    summary_by_soil[[taxon]] <- points_with_soil %>%
      group_by(SOIL) %>%
      summarise(count = n(), 
                avg_x = mean(st_coordinates(points_with_soil)[, 1]), 
                avg_y = mean(st_coordinates(points_with_soil)[, 2]))
  }
  
  # Save map as HTML
  saveWidget(comb_edit, "map_output.html")
  
  # Return results
  return(list(map = comb_edit, vegetation_summary = summary_by_veg, soil_summary = summary_by_soil))
}

# Example function call
gis_analysis(c("Protea cynaroides", "Hydnora africana", "Euphorbiaceae", "Aloe ferox"))
