# How to connect to a CVMFS repository.

## The Cern-VM file system (CVMFS).

The CernVM-FS is a distributed filesystem perfectly designed for sharing readonly data across the globe. We use it in the **[Galaxy Project](https://galaxyproject.org)** for sharing things that a lot of Galaxy servers need. Namely:
* **Reference Data**
    * Genome sequences for hundreds of useful species.
    * Indices for the genome sequences
    * Various bioinformatic tool indices for the available genomes
* **Tool containers**
    * **[Singularity](https://www.sylabs.io/)** containers of everything stored in **[Biocontainers](https://biocontainers.pro/)** (A bioinformatic tool container repository.) You get these for free everytime you build a **[Bioconda](https://bioconda.github.io/)** recipe/package for a tool.
* Others too..

From the Cern website:

*"The CernVM File System provides a scalable, reliable and low-maintenance software distribution service. It was developed to assist High Energy Physics (HEP) collaborations to deploy software on the worldwide-distributed computing infrastructure used to run data processing applications. CernVM-FS is implemented as a POSIX read-only file system in user space (a FUSE module). Files and directories are hosted on standard web servers and mounted in the universal namespace /cvmfs." - [https://cernvm.cern.ch/portal/filesystem](https://cernvm.cern.ch/portal/filesystem)*

## CVMFS and Galaxy

The Galaxy project supports a few CVMFS repositories.


| Repository | Repository Address | Contents |
| ---------- | ------------------ | -------- |
| Reference Data and Indices | `data.galaxyproject.org` | Genome sequences and their tool indices, Galaxy `.loc` files for them as well |
| Singularity Containers | `singularity.galaxyproject.org` | Singularity containers for everything in Biocontainers for use in Galaxy systems |
| Galaxy Main Configuration | `main.galaxyproject.org` | The configuration files etc for Galaxy Main (usegalaxy.org) |

## Setting up an instance to access a CVMFS repository

You will be provided with the ip address of an instance running in the NeCTAR Cloud. It will be running Ubuntu 16.04.  

See [here]() for a list of the available machines.

We are going to log into them via ssh and setup a CVMFS mount to the Galaxy reference data repository as an example.

The images are pretty vanilla, they only have `vim` and `nano` installed outside of the standard NeCTAR Ubuntu image.

#### Step 1: Install the CVMFS client

We need to first install the Cern software apt repo and then the cvmfs client and config utility

```bash
sudo apt install lsb-release
wget https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest_all.deb
sudo dpkg -i cvmfs-release-latest_all.deb
rm -f cvmfs-release-latest_all.deb
sudo apt-get update

sudo apt install cvmfs cvmfs-config
```

Now we need to run the cvmfs setup script.

```bash
sudo cvmfs_config setup
```

#### Step 2: Create some config files and a directory

**default.local**

Create a `/etc/cvmfs/default.local` file with the following contents:

```
CVMFS_REPOSITORIES="data.galaxyproject.org"
CVMFS_HTTP_PROXY="DIRECT"
CVMFS_QUOTA_LIMIT="32000"
CVMFS_CACHE_BASE="/mnt/galaxyIndices/cvmfs/cache"
CVMFS_USE_GEOAPI=yes
```

This tells cvmfs to mount the Galaxy reference data repository and use a specific location for the cache which is limited to 32GB in size and to use the instance's location to choose the best CVMFS repo server to connect to.

**galaxyproject.org.conf**

Create a `/etc/cvmfs/domain.d/galaxyproject.org.conf` file with the following contents:

```
CVMFS_SERVER_URL="http://cvmfs1-psu0.galaxyproject.org/cvmfs/@fqrn@;http://cvmfs1-iu0.galaxyproject.org/cvmfs/@fqrn@;http://cvmfs1-tacc0.galaxyproject.org/cvmfs/@fqrn@;http://cvmfs1-mel0.gvl.org.au/cvmfs/@fqrn@"
```

This is a list of the available tier1 servers that have this repo. Note there is one in Melbourne. We will most likely be connecting to this one.

**data.galaxyproject.org.pub**

Create a `/etc/cvmfs/keys/data.galaxyproject.org.pub` file with the following contents:

```
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5LHQuKWzcX5iBbCGsXGt
6CRi9+a9cKZG4UlX/lJukEJ+3dSxVDWJs88PSdLk+E25494oU56hB8YeVq+W8AQE
3LWx2K2ruRjEAI2o8sRgs/IbafjZ7cBuERzqj3Tn5qUIBFoKUMWMSIiWTQe2Sfnj
GzfDoswr5TTk7aH/FIXUjLnLGGCOzPtUC244IhHARzu86bWYxQJUw0/kZl5wVGcH
maSgr39h1xPst0Vx1keJ95AH0wqxPbCcyBGtF1L6HQlLidmoIDqcCQpLsGJJEoOs
NVNhhcb66OJHah5ppI1N3cZehdaKyr1XcF9eedwLFTvuiwTn6qMmttT/tHX7rcxT
owIDAQAB
-----END PUBLIC KEY-----
```

**galaxyIndices**

Make a directory for the cache files

```
sudo mkdir /mnt/galaxyIndices
```

#### Step 3: Check to see if it is working

Probe the connection.

```
sudo cvmfs_config probe data.galaxyproject.org
```

If this doesn't return `OK` then you may need to restart autofs: `sudo systemctl restart autofs`

#### Step 4: Look at the repository

Go and take a look in `/cvmfs/data.galaxyproject.org`. You will see the contents of the repo. There is quite a lot of data here all available and ready to go..

Just like that....
