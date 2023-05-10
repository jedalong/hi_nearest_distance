##################
## input/output ## adjust!
##################
## Provided testing datasets in `./data/raw`: 
## for own data: file saved as a .rds containing a object of class MoveStack
inputFileName = "./data/raw/fishers.rds" 

## optionally change the output file name
unlink("./data/output/", recursive = TRUE) # delete "output" folder if it exists, to have a clean start for every run
dir.create("./data/output/") # create a new output folder
outputFileName = "./data/output/output.rds" 

##########################
## Arguments/parameters ## adjust!
##########################
# There is no need to define the parameter "data", as the input data will be automatically assigned to it.
# The name of the field in the vector must be exactly the same as in the r function signature
# Example:
# rFunction = function(data, username, department)
# The parameter must look like:
#    args[["username"]] = "my_username"
#    args[["department"]] = "my_department"

args <- list() # if your function has no arguments, this line still needs to be active
# Add all your arguments of your r-function here
args[["r"]] = 50 
args[["key"]] = "building" 
args[["value"]] = "all" 
args[["geom"]] = "polygon"
args[["poly2line"]] = TRUE

##############################
## source, setup & simulate ## leave as is!
##############################
# this file is the home of your app code and will be bundled into the final app on MoveApps
source("RFunction.R")

# setup your environment
Sys.setenv(
    SOURCE_FILE = inputFileName, 
    OUTPUT_FILE = outputFileName, 
    ERROR_FILE="./data/output/error.log", 
    APP_ARTIFACTS_DIR ="./data/output/"
)

# simulate running your app on MoveApps
source("src/moveapps.R")
simulateMoveAppsRun(args)
