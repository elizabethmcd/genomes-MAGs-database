#! /bin/bash

export PROKKA=/opt/bifxapps/prokka

export PATH=$PROKKA/bin:$PATH

for fasta in *.fna; do
    N=$(basename $fasta .fna);
    prokka --outdir $N --prefix $N --cpus 15 $fasta --centre X --compliant;
done
