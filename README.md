# Entinostat-and-NHS-IL12-in-aPD1-aPDL1-refractory-models
Entinostat and NHS-IL12 in aPD1/aPDL1 refractory models

This is a repository for the code and results from this manuscript, originally tracked as project CCBR-1144.

To reproduce these results, follow these steps:

  1.  Clone this GitHub repo (i.e. the page you are on):
      a. https://github.com/NIDAP-Community/Entinostat-and-NHS-IL12-in-aPD1-aPDL1-refractory-models 
  2.  Download the 3 input files from this Zenodo repo:
      a. https://zenodo.org/record/6588571
      b. Place these 3 input files inside the /src/ directory of the cloned GitHub repo (see step #1). 
  3.  Build the docker container:
      a. docker build --tag minnar_et_al_2022_docker
  4.  From within the running docker container:
      a. cd /tmp
      b. bash run_pipeline.sh

Repo description: 
** ./src: The source code
