# GIS Workflow: Hydnora africana and Euphorbiaceae iNAt distributions Explorations : the intial inspiration

This project was intially created explores the iNat observational distributions of *Hydnora africana* and the *Euphorbiaceae* family within the Western Cape.Hydnora is parasitic on Euphorbiaceae and I wanted to see if this was visible in the iNat observations.
It also uses vegetation and soil data to understand the environmental context of these species and provides interactive mapping and spatial analysis tools.

Although it is rather strange and maybe not very useful thing to look the distributions *Hydnora africana* and *Euphorbiaceae* together, I thought that it was good enough data to use to start building my interactive map.

What I should have done was do more research and then plotted the specific species on which *Hydnora africana* is usually parasitic on (instead of just the whole family). I have also plotted only Western Cape (WC) occurrences, which may be misleading/omit some important data (although Hydnora africana is most commonly seen in the WC.

Read below how I decided to circumnavigate these issues...


# GIS Workflow: The final product

What I did was write a function where the user can define which observations (species/genus/family etc.) they would like to select from iNaturalist and then get an interactive and summaries as output (only for the Wesyern Cape as my computer cannot handle generating maps for larger areas).
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

I would like to add a layer for protected areas/conservation areas/private game reserves and summary tables for how many of the observations occurred in these areas.I would also like to add a layer for showing elevation. 
------------------------------------------------------------------------

## **Data Citation**

South African National Biodiversity Institute (2006-2024). The Vegetation Map of South Africa, Lesotho, and Swaziland, Mucina, L., Rutherford, M.C., and Powrie, L.W. (Editors), Online, <https://bgis.sanbi.org/Projects/Detail/2258>, Version 2024.

ISRIC – World Soil Information. (2024). SoilGrids250m: Global gridded soil information at 250 m resolution. Retrieved from <https://data.isric.org/geonetwork/srv/eng/catalog.search#/metadata/c3f7cfd5-1f25-4da1-bce9-cdcdd8c1a9a9>.

iNaturalist. (2025). Observation data for Hydnora africana obtained from iNaturalist on February 27, 2025. Available at: <https://www.inaturalist.org>.

iNaturalist. (2025). Observation data for Euphorbiaceae obtained from iNaturalist on February 27, 2025. Available at: <https://www.inaturalist.org>.

Cartography Vectors. (2025). Western Cape, South Africa Map. Retrieved from <https://cartographyvectors.com/map/1334-western-cape-south-africa>.

------------------------------------------------------------------------
#How to use:

-----------------------------------------------------------
-----------------------------------------------------------

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
