#! /bin/bash

# provide script with list of genbank accession numbers to download

list="$1"

ncbi-genome-download -s genbank -F fasta -A $list all --parallel 4