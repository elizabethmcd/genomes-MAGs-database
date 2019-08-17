#! /bin/bash

# Download a genome assembly from genbank
# Reformat the assembly file
# Predict ORFs and get a .faa file
# Search for a given marker using HMMer
# If there is greater than or equal to 1 hit in the HMM output, write it to a hits file
# Bring back the hits file with the name of the genome as the title, so can then pull down those genome files isntead of all 200,000 just to do the initial search

# installations and set path for all programs to work
tar -xzf anaconda-python.tar.gz
export PATH=$(pwd)/python/bin:$PATH

# make a working directory so doesn't bring back everything under the sun
mkdir wd
mv *.hmm wd
chmod u+x search-genomes.py
cd wd

# get the genome file, unzip, rename
wget $2
gunzip GCA*.gz 
mv *.fna $1.fna

# call ORFS with prodigl and reformat the headers
prodigal -i $1.fna -a $1.faa
sed 's/\s.*$//' $1.faa > $1.faa.fixed

# run HMMsearch and parse results
# will only create a hits file if the HMMer output contains 1 or more hits, IE not empty
python ../search-genome.py --genome $1.faa.fixed --marker tfdA.hmm --output $1-hits.faa

# move the hits file
mv $1-hits.faa /mnt/gluster/emcdaniel/genome-search/.