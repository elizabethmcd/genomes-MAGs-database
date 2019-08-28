#! /bin/bash
# Reformat and call genes on all sequences, outputting the protein files

# unzip downloaded files
gunzip */*.gz
echo Unzipped all files

# rename based on directory name
for filename in */*.fna; do mv $filename ${filename%/*}/${filename%/*}.fna; done
echo Renamed all files

# move to different directory
mkdir annotations
cp */*.fna annotations/
cd annotations

# annotate genomes to get prokka files
# Archaea
for fasta in *.fna; do
    N=$(basename $fasta .fna);
    prokka --kingdom Archaea --outdir $N --prefix $N --cpus 15 --centre X --compliant $fasta;
done