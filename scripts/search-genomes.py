#! /usr/bin/python

import os, sys
import argparse
import subprocess 
from Bio import SeqIO, SearchIO

# setup and arguments
parser = argparse.ArgumentParser(description = "Search genome for marker of interest")
parser.add_argument('--genome', metavar='GENOME', help='Protein fasta file of genome to search')
parser.add_argument('--marker', metavar='MARKER', help="Name of marker to search with")

args = parser.parse_args()
genome = args.genome_dir
marker = args.marker
FNULL = open(os.devnull, 'w')
prot=os.path.basename(marker).replace(".hmm", "").strip().splitlines()[0]

# Run HMM for a single marker
print("Searching for " + prot + " marker in genome set...")
name=os.path.basename(genome).replace(".faa.fixed", "").strip().splitlines()[0]
outname=name + ".out"
cmd = ["hmmsearch","--cut_tc","--tblout="+outname, marker, genome]
subprocess.call(cmd, stdout=FNULL)

# Parse HMM file 
print("Parsing results...")
result_dir = os.walk("out/"+dir)
for path, dirs, files in result_dir:
    for file in files:
        genome = file.replace(".out", "").strip().splitlines()[0]
        result = "out/"+dir+"/"+file
        output="results/"+dir+".faa"
        genome_file=GENOMEDIR+genome+".faa"
        with open(output, "a") as outf:
            with open(genome_file, "r") as input_fasta:
                with open(result, "r") as input:
                    for qresult in SearchIO.parse(input, "hmmer3-tab"):
                        hits = qresult.hits
                        num_hits = len(hits)
                        if num_hits>0:
                            for i in range(0,1):
                                hit_id=hits[i].id
                            for record in SeqIO.parse(input_fasta, "fasta"):
                                if record.id in hit_id:
                                    outf.write(">"+genome+"\n"+str(record.seq)+"\n")

