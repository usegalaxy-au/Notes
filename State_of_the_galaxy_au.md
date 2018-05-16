# State of the Galaxy - AU

## Current State

Currently the Galaxy AU infrastructure consists of three Galaxy services:

1. usegalaxy.org.au - the current production service
   * Machine image: GVL 4.0.0
   * Galaxy version: gvl_4.1.0
   * VM flavor m1-xxlarge
   
2. galaxy-aust-dev.genome.edu.au - the current development service
   * Machine image: GVL-4.3.0
   * Galaxy version: release_18.01
   * VM flavor m1-xxlarge

3. galaxy-aust.genome.edu.au - the intended production service after 17th May
   * Machine image: GVL 4.4.0 Alpha 2
   * Galaxy version: release_18.01
   * VM flavor m2-xlarge
   
## State after 17th May 2018

1. usegalaxy.org.au - new production service commissioned from (3) above
   * Machine image: GVL 4.4.0 Alpha 2
   * Galaxy version: release_18.01
   * Database and data files (/mnt/galaxy/files) from (1) above
   * VM flavor m2-xlarge

2. galaxy-aust-dev.genome.edu.au - the existing development service will continue 
   * Machine image: GVL-4.3.0
   * Galaxy version: release_18.01
   * VM flavor m1-xxlarge
