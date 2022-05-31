# Entinostat-and-NHS-IL12-in-aPD1-aPDL1-refractory-models
Entinostat and NHS-IL12 in aPD1/aPDL1 refractory models

This is a repository for the code and results from this manuscript, originally tracked as project CCBR-1144.

To reproduce these results, follow these steps:

  1.  Clone this GitHub repo (i.e. the page you are on):
      * ```git clone https://github.com/NIDAP-Community/Entinostat-and-NHS-IL12-in-aPD1-aPDL1-refractory-models```
  2.  Download the 3 input files from this Zenodo repo:
      * https://zenodo.org/record/6588571
      * Place these 3 input files inside the ./src/ directory of the cloned GitHub repo (see step #1). 
  3.  Install [docker](https://docs.docker.com/get-docker/) and build the docker container:
      * Move to the /docker/ directory of this repo
      * Run: ```docker build --tag minnar_et_al_2022_docker```
  4.  Run the conainer by mounting the ./src/ director of the repo to /tmp/ in the container and run the following:
      * ```docker run -ti -v $(pwd)/src:/tmp minnar_el_al_2022```
      * ```cd /tmp```
      * ```bash run_pipeline.sh```
