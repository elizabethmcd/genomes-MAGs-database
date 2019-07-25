# Creating a database of reference genomes and metagenome-assembled genomes (MAGs)

This repository is mostly a description of how to build a database of reference genomes from Refseq and metagenome-assembled genomes (MAGs) from multiple large-scale metagenomic projects from various environments. This database does not include human or host associated MAGs, and is mostly for exploring genomes/marker genes of environmental metagenomes. The included scripts cover downloading and reformatting sets of genomes, and subsequently calling genes or performing functional annotations for a specific subset of downloaded genomes for further analyses. 

_Refseq database built in July 2019_

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
