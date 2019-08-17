# Creating a Database of Reference Genomes and Metagenome-Assembled Genomes (MAGs)

This repository is mostly a description of how to build a database of reference genomes from Refseq and metagenome-assembled genomes (MAGs) from multiple large-scale metagenomic projects from various environments. This database does not include human or host associated MAGs, and is mostly for exploring genomes/marker genes of environmental metagenomes. The included scripts cover downloading and reformatting sets of genomes, and subsequently calling genes or performing functional annotations for a specific subset of downloaded genomes for further analyses. 

_Refseq database built in July 2019. As of this date, downloading all complete Refseq genomes and MAGs from the below datasets amounts to approximately 30,000 genomes._

To include all genomes from NCBI regardless of completion status, download the genomes from the accession list `accessions/2019-08-01-incomplete-genbank-genomes-accessions.txt`. This includes all genomes that are of assembly level chromosome, contig, or scaffold deposited in Genbank as of 2019-08-01. The entire metadata file is too large to store on Github, and is stored in an [OSF repository](https://osf.io/ucywj/), with dated folders for updated database files. 

## Requirements

- [ncbi-genome-download](https://github.com/kblin/ncbi-genome-download)
- [Prodigal](https://github.com/hyattpd/Prodigal)
- [Prokka](https://github.com/tseemann/prokka)

## Metagenomic Datasets 

- [Anantharaman et al. 2016](https://www.nature.com/articles/ncomms13219#ref20) "Thousands of microbial genomes shed light on interconnected biogeochemical processes in an aquifer system". Bioproject: [PRJNA288027](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA288027)
- [Parks et al. 2017](https://www.nature.com/articles/s41564-017-0012-7) "Recovery of nearly 8,000 metagenome-assembled genomes substantially expands the tree of life". Bioproject: [PRJNA348753](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA348753)
- [Woodcroft et al. 2018](https://www.nature.com/articles/s41586-018-0338-1?WT.ec_id=NATURE-201807&spMailingID=57022877&spUserID=MjA1NzcwMjE4MQS2&spJobID=1442290015&spReportId=MTQ0MjI5MDAxNQS2) "Genome-centric view of carbon processing in thawing permafrost". Bioproject: [PRJNA386568](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA386568)
- [Crits-Cristoph et al. 2018](https://www.nature.com/articles/s41586-018-0207-y) "Novel soil bacteria possess diverse genes for secondary metabolite biosynthesis". Bioproject:[PRJNA449266](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA449266)
- [Tully et al. 2018](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5769542/) "The reconstruction of 2,361 draft metagenome-assembled genomes from the global oceans". Bioproject: [PRJNA391943](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA391943)
- [Dombrowski et al. 2018](https://www.ncbi.nlm.nih.gov/pubmed/30479325) "Expansive microbial metabolic versatility and biodiversity in dynamics Guaymas Basin hydrothermal sediments". Biproject: [PRJNA362212](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA362212)

## Data

- `ncbi-bioproject-files/` contains individual bioproject accession information for all datasets, from which genomes were downloaded through `ncbi-genome-download` and used to merge metadata
- `bioproject-accession-lists/` contains accession lists for each bioproject, and the combined list for bulk download
- `metadata/` more detaild metadata information on specific metagenomic projects and downloaded genomes from NCBI

# Massively Parallel Search of Genbank Assemblies for Specific Markers

Previously, I would download the entire genbank database (~200,000 genomes) and then go one by one with for loops to reformat, annotate, and search for specific markers of interest. This was extremely tedious, takes up a lot of space on a server, and also takes a long time to go one by one for each of these steps. Using the resources available through HTCondor & UW-Madison Center for High-Throughput Computing, I've repurposed all of these steps so each job is split by a genome assembly, and performs the reformmating, annotating, and marker searches by job. This way the jobs can be highly parallel, and can flock out to other resources such as the open science grid. All that needs to change periodically would be updating the list of genbank assemblies/ftp paths if there are major updates to the database in the `metadata/` folder, and whatever marker you want to search for, which is specified in the `submit` file. 

This pipeline serves somewhat the same and different purposes as the above mentioned steps. For the above, you can search specific, large-scale metagenomic projets for a marker or just to create a nice environmental MAG database. This can search through all Genbank genomes in one-go, including from metagenomic projects. 

To run the pipeline, these steps are highly specific to UW-Madison's HTCondor system, specifically for running on the Center for High Throughput Computing cluster. The steps are a bit convoluted for setup, but once they are done you can perform searches for any marker you choose without downloading all of Genbank locally, which at this point you might consider more worthwhile. 

1. Clone this directory to get all the executables and scripts
2. Follow the directions to install an Anaconda python distribution with prodigal, HMMer, and biopython installed with `conda`.
3. Follow the `prepare-chtc-wrapper.md` instructions based on using the ChtcRun package. The metadata files have already been split up in the `metadata/splits` folder, you just have to follow the directions to configure the ChtcRun package correctly with the `shared` folder and corresponding queue directories. 