# Conda and Bioconda tutorial

This tutorial will get you up and running with Conda and Bioconda.

For an introductory set of slides on Conda and Bioconda see [here](https://docs.google.com/presentation/d/e/2PACX-1vQ8gPzQ8bv5pJJtPAd3e0fe4pt2grnVwtGuoJBcao6RaS-IpiNLnV0nanQAYNGKpPs3wn4iKoIKSsck/pub?start=false&loop=false&delayms=3000)

### Today we are going to:

1. Install Conda via the Miniconda distribution
2. Learn about activation of the base conda environment
3. Configure Conda with Software "Channels"
4. Learn how to:
    * install tools using conda
    * remove tools
    * install a particular version of a tool
    * update tools
5. How to handle version conflicts!
    * Conda environments
6. How to use conda environments
    * Create an environment
    * Add tools to an environment
    * Activate different environments

**Instructions:**
1. Read through the following
2. Run the commands that start with `>$` in your SSH session.

For example, the command `pwd` will be shown as:
```
>$ pwd
```
or
```
(base) >$ pwd
```

Don't type in the `>$` or the `(base) >$`! *It's just the representation of the prompt in the tutorial document...*

Ok, lets go.

## 1. Install Conda *via* the Miniconda distribution.

First thing we have to do is download the installer from the Miniconda documentation website.

SSH Login to your Linux server

Then from your HOME directory:

```
>$ wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

Now we can install it, we will use the `-b` and `-s` switches for *silent mode* and *no post install scripts* respectively.

```

>$ sh Miniconda3-latest-Linux-x86_64.sh -b -s

```

We can watch it install and show the following:

```
PREFIX=/home/ubuntu/miniconda3
installing: python-3.7.3-h0371630_0 ...
Python 3.7.3
installing: ca-certificates-2019.1.23-0 ...
installing: libgcc-ng-8.2.0-hdf63c60_1 ...
installing: libstdcxx-ng-8.2.0-hdf63c60_1 ...
installing: libffi-3.2.1-hd88cf55_4 ...
installing: ncurses-6.1-he6710b0_1 ...
installing: openssl-1.1.1b-h7b6447c_1 ...
installing: xz-5.2.4-h14c3975_4 ...
installing: yaml-0.1.7-had09818_2 ...
installing: zlib-1.2.11-h7b6447c_3 ...
installing: libedit-3.1.20181209-hc058e9b_0 ...
installing: readline-7.0-h7b6447c_5 ...
installing: tk-8.6.8-hbc83047_0 ...
installing: sqlite-3.27.2-h7b6447c_0 ...
installing: asn1crypto-0.24.0-py37_0 ...
installing: certifi-2019.3.9-py37_0 ...
installing: chardet-3.0.4-py37_1 ...
installing: idna-2.8-py37_0 ...
installing: pycosat-0.6.3-py37h14c3975_0 ...
installing: pycparser-2.19-py37_0 ...
installing: pysocks-1.6.8-py37_0 ...
installing: ruamel_yaml-0.15.46-py37h14c3975_0 ...
installing: six-1.12.0-py37_0 ...
installing: cffi-1.12.2-py37h2e261b9_1 ...
installing: setuptools-41.0.0-py37_0 ...
installing: cryptography-2.6.1-py37h1ba5d50_0 ...
installing: wheel-0.33.1-py37_0 ...
installing: pip-19.0.3-py37_0 ...
installing: pyopenssl-19.0.0-py37_0 ...
installing: urllib3-1.24.1-py37_0 ...
installing: requests-2.21.0-py37_0 ...
installing: conda-4.6.14-py37_0 ...
installation finished.
```

## 2. Activate the Conda base environment

Now that we have installed Conda we need to be able to use it.

In a very similar way to activating a Python virtual environment, we need to ***activate*** conda before we can use it.

We do this by pointing the `source` command at the conda activate script.

**NOTE: You need to do this EVERY time you login to your server if you want to use tools you installed with Conda.**

```
>$ source ~/miniconda3/bin/activate
```

You'll notice that your command line now has an added `(base)` in front of it. This lets you know that Conda has been activated and you can use it. Later on, when we start using other conda environments it will tell us which one we are in!

## 3. Configure Conda with software "Channels"

Now we want to configure Conda with some extra software channels. We especially want to tell Conda where it can find all those awesome Bioinformatics tools we really want to use are.

So we need to add three "Channels" to conda's configurtation. They are:

* defaults - base packages for Conda
* bioconda - >8000 Bioinformatics tools and growing daily
* conda-forge - has most of the dependencies for all our favourite tools

We add the channels with the `conda config` command. The order in which we add the channels is very important. It will determine the order in which conda will search them for the appropriate packages. It's strange but the last one we add will have the highest priority. We want `conda-forge` to have the highest priority so we add it last...

```
(base) >$ conda config --add channels defaults
(base) >$ conda config --add channels bioconda
(base) >$ conda config --add channels conda-forge
```
To check that it worked you can look at the conda configuration using:

```
(base) >$ conda config --show
```

It will print out the full configuration of your conda install. If you see:

```
channels:
  - conda-forge
  - bioconda
  - defaults
 ```

amongst the rest of the output, you are all set!

## 4. How to:

Ok, enough setup already! Lets install a tool cause I have project deadlines!

### 4.1 Install a tool

Lets install samtools.. It's pretty useful..

To do that we use the `conda install <package-name>` command.

```
(base) >$ conda install samtools
```

Conda will work out all the things it needs to install as well as samtools to make sure it works.

You'll see a whole lot of stuff, but then conda will ask you if you REALLY want to install `samtools`. Take note of all the other things it has to install.. Look closely, sometimes it may tell you it has to REMOVE things to be able to install what you want due to an incompatibility. We will look at how to get around these things later in section 5.

This is what you should see:

```
Collecting package metadata: done
Solving environment: done

## Package Plan ##

  environment location: /home/ubuntu/miniconda3

  added / updated specs:
    - samtools


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    bzip2-1.0.6                |    h14c3975_1002         415 KB  conda-forge
    ca-certificates-2019.3.9   |       hecc5488_0         146 KB  conda-forge
    certifi-2019.3.9           |           py37_0         149 KB  conda-forge
    conda-4.6.14               |           py37_0         2.1 MB  conda-forge
    curl-7.64.1                |       hbc83047_0         138 KB
    krb5-1.16.1                |       h173b8e3_7         1.4 MB
    libcurl-7.64.1             |       h20c2e04_0         582 KB
    libdeflate-1.0             |       h14c3975_1          43 KB  bioconda
    libssh2-1.8.2              |       h22169c7_2         257 KB  conda-forge
    openssl-1.1.1b             |       h14c3975_1         4.0 MB  conda-forge
    samtools-1.9               |      h8571acd_11         636 KB  bioconda
    ------------------------------------------------------------
                                           Total:         9.7 MB

The following NEW packages will be INSTALLED:

  bzip2              conda-forge/linux-64::bzip2-1.0.6-h14c3975_1002
  curl               pkgs/main/linux-64::curl-7.64.1-hbc83047_0
  krb5               pkgs/main/linux-64::krb5-1.16.1-h173b8e3_7
  libcurl            pkgs/main/linux-64::libcurl-7.64.1-h20c2e04_0
  libdeflate         bioconda/linux-64::libdeflate-1.0-h14c3975_1
  libssh2            conda-forge/linux-64::libssh2-1.8.2-h22169c7_2
  samtools           bioconda/linux-64::samtools-1.9-h8571acd_11

The following packages will be UPDATED:

  ca-certificates    pkgs/main::ca-certificates-2019.1.23-0 --> conda-forge::ca-certificates-2019.3.9-hecc5488_0

The following packages will be SUPERSEDED by a higher-priority channel:

  certifi                                         pkgs/main --> conda-forge
  conda                                           pkgs/main --> conda-forge
  openssl              pkgs/main::openssl-1.1.1b-h7b6447c_1 --> conda-forge::openssl-1.1.1b-h14c3975_1


Proceed ([y]/n)? y


Downloading and Extracting Packages
openssl-1.1.1b       | 4.0 MB    | ############################################################################ | 100%
libssh2-1.8.2        | 257 KB    | ############################################################################ | 100%
libdeflate-1.0       | 43 KB     | ############################################################################ | 100%
samtools-1.9         | 636 KB    | ############################################################################ | 100%
ca-certificates-2019 | 146 KB    | ############################################################################ | 100%
krb5-1.16.1          | 1.4 MB    | ############################################################################ | 100%
libcurl-7.64.1       | 582 KB    | ############################################################################ | 100%
bzip2-1.0.6          | 415 KB    | ############################################################################ | 100%
certifi-2019.3.9     | 149 KB    | ############################################################################ | 100%
curl-7.64.1          | 138 KB    | ############################################################################ | 100%
conda-4.6.14         | 2.1 MB    | ############################################################################ | 100%
Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```


Ok, so now we can check it out..

```
(base) >$ samtools --version

samtools 1.9
Using htslib 1.9
Copyright (C) 2018 Genome Research Ltd.
```

Woohoo!

Ok so now we can install `BWA` with the following:

```
(base) >$ conda install bwa
```
Now lets check this one.

```
(base) >$ bwa

Program: bwa (alignment via Burrows-Wheeler transformation)
Version: 0.7.17-r1188
Contact: Heng Li <lh3@sanger.ac.uk>

Usage:   bwa <command> [options]

Command: index         index sequences in the FASTA format
         mem           BWA-MEM algorithm
         fastmap       identify super-maximal exact matches
         pemerge       merge overlapping paired ends (EXPERIMENTAL)
         aln           gapped/ungapped alignment
         samse         generate alignment (single ended)
         sampe         generate alignment (paired ended)
         bwasw         BWA-SW for long queries

         shm           manage indices in shared memory
         fa2pac        convert FASTA to PAC format
         pac2bwt       generate BWT from PAC
         pac2bwtgen    alternative algorithm for generating BWT
         bwtupdate     update .bwt to the new format
         bwt2sa        generate SA from BWT and Occ

Note: To use BWA, you need to first index the genome with `bwa index'.
      There are three alignment algorithms in BWA: `mem', `bwasw', and
      `aln/samse/sampe'. If you are not sure which to use, try `bwa mem'
      first. Please `man ./bwa.1' for the manual.
```

### 4.2 Remove a tool

To remove a tool is simple. Just use the `conda remove` instruction.

```
(base) >$ conda remove samtools

```

You'll have to acknowledge that you actually want to remove samtools.

Now try to run samtools..

```
(base) >$ samtools

Command 'samtools' not found, but can be installed with:

sudo apt install samtools
```
It's not there anymore.. Cool..

### 4.3 Install a particular **version** of a tool.

Last time we installed samtools we got version 1.9 but we really wanted version 1.8. We can install version 1.8 pretty easily. We just tell Conda what version we want when we install it.

```
(base) >$ conda install samtools==1.8
```
notice the `==1.8`? This tells Conda to install a particular version and in this case 1.8.

This is really handy sometimes.

When you install this version, notice that Conda has to re-jig some of it's other installed programs? This happens a lot and it could effect other things you might have installed. That's where conda environments come in and we'll talk about them soon.

For now run `samtools --version` again.

```
(base) >$ samtools --version

samtools 1.8
Using htslib 1.8
Copyright (C) 2018 Genome Research Ltd.
```
Cool.

### 4.4 Update a tool

Sometimes we want to upgrade a tool that is already installed. We can do this by using the `conda update <package-name>` command.

Lets update samtools to it's latest version.

```
(base) >$ conda update samtools
```

Once it's done, check it's version again.

```
(base) >$ samtools --version
samtools 1.9
Using htslib 1.9
Copyright (C) 2018 Genome Research Ltd.
```

Simples.

### 4.5 Find out what tools are installed.

It's pretty easy, we just use the `conda list` command. It will tell you what is installed, which versions, build numbers and which channel it came from.

```
(base) >$ conda list
# packages in environment at /home/ubuntu/miniconda3:
#
# Name                    Version                   Build  Channel
asn1crypto                0.24.0                py27_1003    conda-forge
bwa                       0.7.17               h84994c4_5    bioconda
bzip2                     1.0.6             h14c3975_1002    conda-forge
ca-certificates           2019.3.9             hecc5488_0    conda-forge
certifi                   2019.3.9                 py27_0    conda-forge
cffi                      1.12.3           py27h8022711_0    conda-forge
chardet                   3.0.4                 py27_1003    conda-forge
conda                     4.6.14                   py27_0    conda-forge
cryptography              2.6.1            py27h72c5cf5_0    conda-forge
curl                      7.64.1               hbc83047_0
enum34                    1.1.6                 py27_1001    conda-forge
futures                   3.2.0                 py27_1000    conda-forge
idna                      2.8                   py27_1000    conda-forge
ipaddress                 1.0.22                     py_1    conda-forge
krb5                      1.16.1               h173b8e3_7
libcurl                   7.64.1               h20c2e04_0
libdeflate                1.0                  h14c3975_1    bioconda
libedit                   3.1.20170329      hf8c457e_1001    conda-forge
libffi                    3.2.1                hd88cf55_4
libgcc-ng                 8.2.0                hdf63c60_1
libssh2                   1.8.2                h22169c7_2    conda-forge
libstdcxx-ng              8.2.0                hdf63c60_1
ncurses                   6.1               hf484d3e_1002    conda-forge
openssl                   1.1.1b               h14c3975_1    conda-forge
perl                      5.26.2            h516909a_1006    conda-forge
pip                       19.1                     py27_0    conda-forge
pycosat                   0.6.3           py27h14c3975_1001    conda-forge
pycparser                 2.19                     py27_1    conda-forge
pyopenssl                 19.0.0                   py27_0    conda-forge
pysocks                   1.7.0                    py27_0    conda-forge
python                    2.7.15            h721da81_1008    conda-forge
readline                  7.0               hf8c457e_1001    conda-forge
requests                  2.22.0                   py27_0    conda-forge
ruamel_yaml               0.15.71         py27h14c3975_1000    conda-forge
samtools                  1.9                 h8571acd_11    bioconda
setuptools                41.0.1                   py27_0    conda-forge
six                       1.12.0                py27_1000    conda-forge
sqlite                    3.26.0               h7b6447c_0
tk                        8.6.9             h84994c4_1001    conda-forge
urllib3                   1.24.3                   py27_0    conda-forge
wheel                     0.33.4                   py27_0    conda-forge
xz                        5.2.4                h14c3975_4
yaml                      0.1.7                had09818_2
zlib                      1.2.11               h7b6447c_3
```


## 5. How to handle version conflicts

Just say you need two versions of samtools installed. Samtools is used a lot as a dependency in a lot of other tools and they sometimes need particular versions. What if you want to use `tool-a` which has a dependency for `samtools 1.8` and you also want to use `tool-b` which needs `samtools 1.9`. What do you do? You can't have samtools 1.8 & 1.9 at the same time can you?

**Yes you can!** You just need to install `tool-a` and `tool-b` in different and separate **environments** with their own set of dependencies that do not interact with one another!

To create a conda environment we use the `conda create` command. We will now look at how to use environments!

## 6. How to use Conda environments

Lets install a tool called `mlst` into it's own environment. It has a lot of dependencies and is quite a complex tool.

First thing we need to do is create an *environment* for it.

### 6.1 Create a conda environment

We can create an environment for mlst as follows:

```
(base) >$ conda create -n mlst_env
```

This will create an environment space called `mlst_env` that we can now **activate** and install tools into.

Before we can use our new environment, we have to **activate** it. We use the activate command.

If we have already activated a conda environment (including the `base` environment) we just have to use the `conda activate <environment-name>` command.

However, if we haven't activated Conda yet and we know the name of the environment we want to activate then we have to source it just like we did for the original (base) environment. `source ~/miniconda3/bin/activate <environment-name>`.

We have already got Conda activated so we switch to `mlst_env` as follows:

```
(base) >$ conda activate mlst_env
```

Immediately, you'll notice that the prompt has changed and now we have it prepended with `(mlst_env)` instead of `(base)`.

**NOTE: You can only have one environment activated at a time (for each SSH session.)**

If we run `conda list` now it should be empty..

```
(mlst_env) >$ conda list
# packages in environment at /home/ubuntu/miniconda3/envs/mlst_env:
#
# Name                    Version                   Build  Channel
```

Now that we have activated our environment, we can install tools into it.

```
(mlst_env) >$ conda install mlst
```
It will take quite a long time to install it as it has a LOT of dependencies.

But it will happen and when it's finished we can check it out.

```
(mlst_env) >$ mlst --help
SYNOPSIS
  Automatic MLST calling from assembled contigs
USAGE
  % mlst --list                                            # list known schemes
  % mlst [options] <contigs.{fasta,gbk,embl}[.gz]          # auto-detect scheme
  % mlst --scheme <scheme> <contigs.{fasta,gbk,embl}[.gz]> # force a scheme
GENERAL
  --help            This help
  --version         Print version and exit(default ON)
  --check           Just check dependencies and exit (default OFF)
  --quiet           Quiet - no stderr output (default OFF)
  --threads [N]     Number of BLAST threads (suggest GNU Parallel instead) (default '1')
  --debug           Verbose debug output to stderr (default OFF)
SCHEME
  --scheme [X]      Don't autodetect, force this scheme on all inputs (default '')
  --list            List available MLST scheme names (default OFF)
  --longlist        List allelles for all MLST schemes (default OFF)
  --exclude [X]     Ignore these schemes (comma sep. list) (default 'ecoli_2,abaumannii')
OUTPUT
  --csv             Output CSV instead of TSV (default OFF)
  --json [X]        Also write results to this file in JSON format (default '')
  --label [X]       Replace FILE with this name instead (default '')
  --nopath          Strip filename paths from FILE column (default OFF)
  --novel [X]       Save novel alleles to this FASTA file (default '')
  --legacy          Use old legacy output with allele header row (requires --scheme) (default OFF)
SCORING
  --minid [n.n]     DNA %identity of full allelle to consider 'similar' [~] (default '95')
  --mincov [n.n]    DNA %cov to report partial allele at all [?] (default '10')
  --minscore [n.n]  Minumum score out of 100 to match a scheme (when auto --scheme) (default '50')
PATHS
  --blastdb [X]     BLAST database (default '/home/ubuntu/miniconda3/envs/abricate_env/bin/../db/blast/mlst.fa')
  --datadir [X]     PubMLST data (default '/home/ubuntu/miniconda3/envs/abricate_env/bin/../db/pubmlst')
HOMEPAGE
  https://github.com/tseemann/mlst - Torsten Seemann
```

We can manipulate what is installed in this environment in the same manner we did for the `(base)` environment.

### 6.2 Create an environment and install tools into it at the same time

The above was a few too many steps and as computer scientists we like typing less.. So..

Lets create a new environment for version 1.8 of samtools as well as BWA and install them too.

We can do it all with one command.

First we need to exit the `(mlst_env)` environment and go back to the `(base)` environment.

```
(mlst_env) >$ conda deactivate
```

Now we can create our new environment for samtools and install it.

```
(base) >$ conda create -n bwa_samtools_1_8 samtools==1.8 bwa
```

This command will create an environment called `bwa_samtools_1_8` and then install samtools version 1.8 and a compatible version of bwa into it.

Cool huh?


## The End.

Well, that's it. Hopefully you now understand how to use conda and conda environments to install and use all of your favourite tools!
