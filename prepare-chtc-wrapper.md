# Prepare Batches of Genome Searches for Wrapped Submission Jobs in HTCondor

These steps are now a little convoluted, but this is the easiest way to submit over and over again different genome searches with different markers, since the metadata preparation steps don't have to be repeated that much. 

From the home directory of the login node, download the ChtcRun package and decompress it: 

```
wget http://chtc.cs.wisc.edu/downloads/ChtcRun.tar.gz
```

Create a directory called `genomeSearch`. Within that directory, create a directory called `shared`. In that directory, put the anaconda python installation tarball, `search-genomes.py` script, `search-genomes.sh` executable, and whatever HMM you want to search with. This will be like when you tell a submit file what your executable is, and all the files you need to send over as well (installations, auxillary scripts and files). 

If this step isn't already done, as in the `metadata/splits` folder has a bunch of files and not directories, you will need to do the following:

From the `metadata/splits` directory, run: 

```
for file in genomes*; do dir=$(basename $file)-list; mkdir $dir; mv $file $file-list/genomes.txt; done
```

This will create a uniquely named directory for each list of 500 genomes, but within each directory is a file named genomes.txt. For the submission wrapper to work, each submission file has to be named the same, from as far as I can tell. Move or copy over these directories to the `ChtcRun/genomes/` directory, and now you'll have a bunch of directories named `genomes-nnnn-lists` and the `shared` directory. The current version of this repository contains the uniqely named directories and the same named file in each one in the `metadata/splits` folder, so you shouldn't have to re-do this unless you updated the master metadata file. 

You shouldn't need to update the `process.template` file, as these jobs really only need less than 1MB of memory, 1GB of space, and 1 CPU, which are already included in the process configuration file by default. This will use the vanilla universe since the resulting output files are pretty small. You will need to uncomment the lines `+WantFlocking = true` and `+WantGlidein = true` to distribute jobs to other HTCondor pools and the Open Science Grid, since these jobs are most definitely less than 4 to 2 hours long, respectively. They quite honestly probably take less than 1 minute to download, predict ORFs, search the HMM, and bring back the hits.

You will then need to run the command to make the DAG for submission. The output directory is not made before the DAG is submitted, the job scheduler will make it for you. Since this is queueing by the genomes.txt in each directory and just running the scripts on each batch of files, this should work?

```
./mkdag --cmdtorun=search-genomes.sh --data=genomeSearch --outputdir=genomeHits --pattern=.faa --parg=genomes.txt --type=Other
```
