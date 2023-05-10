# HI Nearest Distance

HI_nearest_distance

Github repository: github.com/jedalong/HI_nearest_distance

## Description
This app facilitates nearest distance analysis to features in Open Street Map (OSM).

## Documentation
This app computes the distance, from each tracking fix, to the nearest OSM feature. It extracts the 'key' of the nearest feature, the key 'value' of the nearest feature, and the distance (in the units of the MoveStack CRS).

The OSM key, which is essentially a class of features in OSM, can be specified as an input variable. The default is to use the 'highway' key which includes roads, trails, etc.

The OSM value, which is essentially the typology of features within a given OSM key, can also be specified as an input variable. The default is to use all of the values in a given key, but single values can be specified for more targeted analysis.

The geom argument can be used to focus on a specific geometry type: one of 'point', 'line' (the default), or 'polygon'. The poly2line argument is used to convert polygon features to lines, useful when studying distance-to-boundary problems.


### Input data

MoveStack in Movebank format

### Output data

MoveStack in Movebank format with three additional columns:
- nearest_key - the OSM key of the nearest feature
- nearest_value - the OSM value of the nearest feature
- nearest_distance - the distance to the nearest OSM feature in appropriate units

### Artefacts

`DistanceAnalysisPlot_r_*.pdf`: Pdf of plots with distance to nearest feature (y-axis) against time (x-axis) for each individual in the MoveStack.
`DistanceAnalysisTable_r_*.csv`: A csv file with table of the number of tracking fixes < r for each type.  

### Settings 

`r`: (numeric) The parameter `r` is used to determine a threshold distance, which is used to determine when fixes are within a given distance of features. The parameter `r` only impacts the artefact outputs. Unit: same unit as input CRS.

`key`: (string) OSM key class, as a string. Default is 'highway'. For more information see the (OSM Wiki Page)[ https://wiki.openstreetmap.org/wiki/Tags#Keys_and_values].

`value`: (string) OSM value tag, as a string. Default is to use all values for a specified key, but the user can choose specific value tags for more targeted analysis. For more information see the (OSM Wiki Page)[ https://wiki.openstreetmap.org/wiki/Tags#Keys_and_values].

`geom`: (string) geometry type to focus on, one of ('point', 'line', 'polygon'). Default is 'line'.

`poly2line`: (logical) used to convert polygon features to lines, useful when studying distance-to-boundary problems. Default is TRUE.

### Most common errors

- specified key/value is not present (check spelling of key and value settings)
- OSM data (for chosen key/value) not present in study area (overlay GPS data on OSM to check )

### Null or error handling

***Input MoveStack:** If input data is of class: "Move", it is automatically converted to a "MoveStack". If it is another type of object the function returns NULL. 
