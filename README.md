# GIS Workflow: Hydnora africana and Euphorbiaceae iNAt distributions Explorations : the intial inspiration

This project was intially created to explore the iNat observational distributions of *Hydnora africana* and the *Euphorbiaceae* family within the Western Cape.Hydnora africana is parasitic on the roots of Euphorbiaceae and I wanted to see if this was visible in the iNat observations.
The GIS analysis also uses vegetation and soil data to understand the environmental context of these species and provides interactive mapping and spatial analysis tools.

Although it is rather strange and maybe not very useful to look the distributions *Hydnora africana* and *Euphorbiaceae* together, I thought that it was good enough data to use to start building my interactive map.

I should have done more research and then plotted the specific species that *Hydnora africana* is usually parasitic on (instead of just the whole family). I have also plotted only Western Cape (WC) occurrences, which may be misleading/omit some important data (although Hydnora africana is most commonly seen in the WC.

Read below how I decided to circumnavigate these issues...


# GIS Workflow: The final product

What I did was write a function where the user can define which observations (species/genus/family etc.) they would like to select from iNaturalist and then get an interactive and summaries as output (only for the Western Cape as my computer cannot handle generating maps for larger areas).This function is meant to be a data exploration tool and could possibly be used to visually look for correlations between spatial data.

All the use has to do is enter the names of whichever groups they would like to explore.

The code then returns:

1. An interactive map with:

 - The individual data points for each group (with labels and links to the observation)
 - Buffer areas of 10km and 1km around each point to see how close they are to each other and how individual points overlap.
 
2. Layers for the map:

  - Different map base layers from Open Street Maps
  - Different layers (with labels) of vegetation types and Soil types
  
3.Output tables showing how many observations occurred in:

  - Each vegetation type area
  - Each soil type

### Room for improvement:

- add a layer for protected areas/conservation areas/private game reserves and summary tables for how many of the observations occurred in these areas.
- add a layer for showing elevation. 
- add an input where the user can define their own buffer area around points (or not at all).
- find a suitable legend for the soil type data: the legend it came with was in an ArcGis format so i couldn't access it, for now all you can see is the soil code type ands you have to search for the soil name in google.

------------------------------------------------------------------------

## **Data Citation**

South African National Biodiversity Institute (2006-2024). The Vegetation Map of South Africa, Lesotho, and Swaziland, Mucina, L., Rutherford, M.C., and Powrie, L.W. (Editors), Online, <https://bgis.sanbi.org/Projects/Detail/2258>, Version 2024.

ISRIC – World Soil Information. (2024). SoilGrids250m: Global gridded soil information at 250 m resolution. Retrieved from <https://data.isric.org/geonetwork/srv/eng/catalog.search#/metadata/c3f7cfd5-1f25-4da1-bce9-cdcdd8c1a9a9>.

- THE SOIL DATA FOR SOUTH AFRICA https://data.isric.org/geonetwork/srv/api/records/c3f7cfd5-1f25-4da1-bce9-cdcdd8c1a9a9 

iNaturalist. (2025). Observation data for Hydnora africana obtained from iNaturalist on February 27, 2025. Available at: <https://www.inaturalist.org>.

iNaturalist. (2025). Observation data for Euphorbiaceae obtained from iNaturalist on February 27, 2025. Available at: <https://www.inaturalist.org>.

Cartography Vectors. (2025). Western Cape, South Africa Map. Retrieved from <https://cartographyvectors.com/map/1334-western-cape-south-africa>.

------------------------------------------------------------------------
# How to use this repository:

The raw R code is available, as well as the code in the form of an Rmarkdown file with annotations. The code contains the initial map building code and the function code which automates the entire process. There is also a separate R file with just the function code if you only want to look at that.

The output from the code is available from this link below (dropbox folder). The dropbox also contains the shape files required to run the analysis on your own machine. All you need to do is download the code and the files and then rename the path for which the files are read in (set your own working directory and read the data from wherever you stored it.)

If you just want to see the output - interactive maps and code - open the *GIS-ANALYSIS* html file. 
NOTE: I also added an example output for the function section of the code, this is stored in the *map-output.html*

------------------------------------------------------------------------

## **License**

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

------------------------------------------------------------------------

## **Contact**

For any questions or suggestions, please contact:
**Your Name**
Email: [nlvantol9\@gmail.com](mailto:nlvantol9@gmail.com)
GitHub: [MajorGiT89](https://github.com/MajorGiT89)

------------------------------------------------------------------------

