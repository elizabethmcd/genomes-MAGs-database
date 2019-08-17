#! /bin/bash

# Download a genome assembly from genbank
# Reformat the assembly file
# Predict ORFs and get a .faa file
# Search for a given marker using HMMer
# If there is greater than or equal to 1 hit in the HMM output, write it to a hits file
# Bring back the hits file with the name of the genome as the title, so can then pull down those genome files isntead of all 200,000 just to do the initial search

# installations and setup
tar -xzf anaconda-bio-python.tar.gz
export PATH=$(pwd)/python/bin:$PATH
chmod u+x search-genomes.py

# set arguments from the list that is queued in from the DAG
list=`basename $1`
while read line
do
assembly=`echo $line | cut -d' ' -f1`
ftp=`echo $line | cut -d' ' -f2`
file=`basename $ftp`
genome=`basename $file .gz`
wget $ftp
gunzip $file
mv $genome $assembly.fna
done < $list

# call ORFS with prodigl and reformat the headers
export PATH=$(pwd)/python/bin:$PATH
for file in *.fna; do
    name=$(basename $file .fna);
    prodigal -i $file -a $name.faa;
done

for file in *.faa; do
    name=$(basename $file .faa);
    sed 's/\s.*$//' $file > $name.faa.fixed;
done

# run HMMsearch and parse results
# will only create a hits file if the HMMer output contains 1 or more hits, IE not empty
for file in *.faa.fixed; do
    name=$(basename $file .faa.fixed);
    python search-genomes.py --genome $file --marker tfdA.hmm --output $name.faa.hits;
done

# move the hits file
# to only bring back hits, have to get rid of everything else so the disk quota doesn't get full
rm *.fna
rm *.faa
rm *.fixed
rm *.out
# mv $1-hits.faa /mnt/gluster/emcdaniel/genome-search/.
# will bring back everything to the output folder, but then can just keep the *-hits.faa files