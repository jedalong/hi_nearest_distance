# Developing with the MoveApps SDK

### General notes

- get an overview with the help of the [user manual](https://docs.moveapps.org/#/create_app)
- files needed for your app:
  - your app codes goes to `./RFunction.R`
  - setup your app arguments and your environment by adjusting `./appspec.json`
  - the documentation of your app goes to `./README.md`
- to run and test your app code locally in a simulated MoveApps environment adjust and execute the file `./co-pilot-sdk.R`
  - adjust the `inputFileName`
  - state the arguments of your function if present

### R packages management (optional)

The template is prepared to use [`renv` as a dependency manager](https://rstudio.github.io/renv/articles/renv.html) - but is disabled ("opt-in") by default.    
You can [activate `renv` with `renv::activate()`](https://rstudio.github.io/renv/articles/renv.html#uninstalling-renv) and then use it in the [usual `renv` workflow](https://rstudio.github.io/renv/articles/renv.html#workflow).


### Docker support (optional)

- at the end your app will be executed on MoveApps in a Docker container.
- if you like you can test your app in the almost final environment by running your app locally in a docker container:

1. add each R library you added to your app via `renv` to the docker image by adding eg. `RUN R -e 'remotes::install_version("foreach")'` to the `./Dockerfile` before `RUN R -e 'renv::restore()'`
1. set a working title for your app by `export MY_MOVEAPPS_APP=hello-world`
1. build the Docker image locally by `docker build -t $MY_MOVEAPPS_APP .`
1. execute the image with `docker run --rm --name $MY_MOVEAPPS_APP -it $MY_MOVEAPPS_APP`
1. you will get a `bash` terminal of the running container. There you can get a R console by `R` or simply start your app by invoking `/home/moveapps/co-pilot-r/start-process.sh` inside the running container.
