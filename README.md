# GIS Workflow: Hydnora africana and Euphorbiaceae iNAt distributions Explorations

This project explores the iNat observation distributions of *Hydnora africana* and the *Euphorbiaceae* family within the Western Cape.Hydnora is parasitic on Euphorbiaceae and i wanted to see if this was visible in the iNat observations.Many additional layers are added on to explore in which contexts they occur.

# GIS Workflow: Vegetation and Soil Analysis

This project explores the distribution of *Hydnora africana* and the *Euphorbiaceae* family within the Western Cape, South Africa. It uses vegetation and soil data to understand the environmental context of these species and provides interactive mapping and spatial analysis tools.

------------------------------------------------------------------------

## **Data Citation**

South African National Biodiversity Institute (2006-2024). The Vegetation Map of South Africa, Lesotho, and Swaziland, Mucina, L., Rutherford, M.C., and Powrie, L.W. (Editors), Online, <https://bgis.sanbi.org/Projects/Detail/2258>, Version 2024.

ISRIC – World Soil Information. (2024). SoilGrids250m: Global gridded soil information at 250 m resolution. Retrieved from <https://data.isric.org/geonetwork/srv/eng/catalog.search#/metadata/c3f7cfd5-1f25-4da1-bce9-cdcdd8c1a9a9>.

iNaturalist. (2025). Observation data for Hydnora africana obtained from iNaturalist on February 27, 2025. Available at: <https://www.inaturalist.org>.

iNaturalist. (2025). Observation data for Euphorbiaceae obtained from iNaturalist on February 27, 2025. Available at: <https://www.inaturalist.org>.

Cartography Vectors. (2025). Western Cape, South Africa Map. Retrieved from <https://cartographyvectors.com/map/1334-western-cape-south-africa>.

------------------------------------------------------------------------

## **Requirements**

### **R Packages**

The following R packages are required for this workflow:\
- `patchwork`: Combining ggplot2 plots.\
- `tidyverse`: Data manipulation and visualization.\
- `ctv`: Install CRAN task views.\
- `rinat`: Accessing iNaturalist data.\
- `sf`: Handling spatial data.\
- `rosm`, `ggspatial`, `prettymapr`: Map visualization and annotation.\
- `leaflet`, `htmltools`, `mapview`, `leafpop`: Interactive mapping.\
- `wesanderson`: Color palettes.\
- `htmlwidgets`, `rmarkdown`: Creating interactive documents.

**Install all packages using:**

``` r
packs <- c("patchwork","tidyverse","ctv","rinat","sf","rosm","ggspatial","prettymapr", "leaflet", "htmltools", "mapview", "leafpop", "wesanderson","htmlwidgets","rmarkdown")
install.packages(packs)
```

------------------------------------------------------------------------

## **Workflow Overview**

### 1. **Load Data**

-   Load vegetation and soil data using `st_read()`.\
-   Fetch iNaturalist observations for *Hydnora africana* and *Euphorbiaceae* using `get_inat_obs()`.\
-   Reproject and crop data to the Western Cape.

------------------------------------------------------------------------

### 2. **Spatial Filtering**

-   Filter iNaturalist data for accuracy, latitude, and quality using:\

``` r
filter_data <- function(data) {
  data %>%
    filter(latitude < 0, !is.na(latitude), 
           captive_cultivated == "false", quality_grade == "research")
}
```

-   Convert filtered data into spatial objects using `st_as_sf()`.\
-   Crop all spatial data to the Western Cape polygon using `st_intersection()`.

------------------------------------------------------------------------

### 3. **Interactive Mapping**

-   Create interactive maps using `mapview` with custom colors and popups for species observations.\
-   Example for *Hydnora africana*:

``` r
HAm <- mapview(HA, col.regions = "purple", legend.title = "Hydnora", 
               popup = popupTable(lpcHA, zcol = c("scientific_name","user_login", "click_url")),
               layer.name = "Hydnora africana")
```

-   Combine multiple layers for vegetation types, soil types, and species distributions.

------------------------------------------------------------------------

### 4. **Spatial Analysis**

-   **Summarizing Points by Vegetation Type**:

    -   Spatial join with vegetation polygons.
    -   Summarize observations by vegetation type.\

    ``` r
    HA_summary_by_vegetation <- HA_points_with_vegetation %>%
    group_by(T_Name) %>%
    summarise(count = n())
    ```

-   **Summarizing Points by Soil Type**:

    -   Spatial join with soil polygons.
    -   Summarize observations by soil type.

------------------------------------------------------------------------

### 5. **Buffer Analysis**

-   Create 10 km and 1 km buffers around *Hydnora africana* points to explore proximity of *Euphorbiaceae* observations.\

``` r
HA_buffer10 <- st_buffer(HA, dist = 10000)
HA_buffer1 <- st_buffer(HA, dist = 1000)
```

-   Check which *Euphorbiaceae* points fall within the buffers using `st_intersects()`.\
-   Visualize the results with overlapping buffer layers in `mapview`.

------------------------------------------------------------------------

### 6. **Interactive Map Export**

-   Combine all maps and export as interactive HTML using `leaflet` and `mapview`.\
-   Set view, max bounds, and add custom CSS for improved visualization:\

``` r
comb.edit <- combined_map@map %>%
  setView(lng = -31, lat = 21, zoom = 6) %>%
  setMaxBounds(lng1 = 17, lat1 = -35, lng2 = 25, lat2 = -30)
```

------------------------------------------------------------------------

## **Usage**

1.  **Clone the Repository**\

``` sh
git clone https://github.com/YourUsername/GIS-WORKFLOW.git
cd GIS-WORKFLOW
```

2.  **Set Working Directory and Clear Workspace**\
    Make sure to set your working directory at the beginning of your R script:\

``` r
setwd("~/UCT_2025/GIT/GIS-WORKFLOW")
rm(list = ls())
```

3.  **Run the R Script**\
    Open the R script in RStudio and run all chunks sequentially, or use:\

``` r
source("path_to_script.R")
```

4.  **View Interactive Maps**\
    The interactive maps will open in the RStudio Viewer pane. Exported HTML maps can be opened in any browser.

------------------------------------------------------------------------

## **Data Sources**

1.  **Vegetation Map of South Africa**
    -   Mucina, L., Rutherford, M.C., and Powrie, L.W. (2024).\
    -   <https://bgis.sanbi.org/Projects/Detail/2258>
2.  **iNaturalist Observations**
    -   Fetched using the `rinat` package.

------------------------------------------------------------------------

## **Contributing**

Contributions are welcome! Please create a pull request with your changes and ensure the following:\
- Clear and concise commit messages.\
- Well-documented code additions or modifications.\
- Test your changes locally before submitting.

------------------------------------------------------------------------

## **License**

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

------------------------------------------------------------------------

## **Contact**

For any questions or suggestions, please contact:\
**Your Name**\
Email: [your.email\@example.com](mailto:your.email@example.com)\
GitHub: [YourUsername](https://github.com/YourUsername)

------------------------------------------------------------------------

This README provides an overview of the GIS workflow for vegetation and soil analysis, including setup instructions, data sources, and detailed workflow steps. If you need additional features or have any issues, feel free to reach out!
