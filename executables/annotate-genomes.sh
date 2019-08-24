#! /bin/bash

# download a genome assembly from genbank
# functionally annotate with prokka
# bring back tarball

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

# functional annotation with prokka
# default as bacteria, once have the genomes downloaded can reassess and change the archaeal ones
for file in *.fna; do
    N=$(basename $file .fna);
    prokka --outidr $N --prefix $N --cpus 1 $file --centre X --compliant; 
done

# tarball the annotation directory
tar -czvf $assembly.tar.gz $assembly/
rm *.fna
rm -rf $assembly/
