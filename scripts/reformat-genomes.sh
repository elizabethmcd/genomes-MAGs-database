#! /bin/bash
# Reformat and call genes on all sequences, outputting the protein files

# unzip downloaded files
gunzip */*.gz
echo Unzipped all files

# rename based on directory name
for filename in */*.fna; do mv $filename ${filename%/*}/${filename%/*}.fna; done
echo Renamed all files

# call genes with Prodigal and output proteins
for file in */*.fna; do 
    N=$(basename $file .fna);
    prodigal -i $file -a $N/$N.faa;
done

