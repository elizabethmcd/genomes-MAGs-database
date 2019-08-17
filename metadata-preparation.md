# Preparing Genbank Assembly File for Queued Submissions

The raw genbank metadata file was downloaded, and filtered as such:
```
awk -F "," '{print $6"\t"$15}' 2019-08-15-all-genbank-genomes.csv | tail -n +2 | sed 's/"//g' | awk -F "/" '{print $1"/"$2"/"$3"/"$4"/"$5"/"$6"/"$7"/"$8"/"$9"/"$10"/"$10"_genomic.fna.gz"}' > 2018-08-16-genbank-accessions-ftp-list.tsv
```

This creates a tab-delimited file of each genbank assembly name and the ftp path to download with `wget` in the job. 

To then split the metadata file into batches of 500 lines, or thus 500 jobs per submission:

```
# in the metadata folder
mkdir splits
split -a 5 -l 50 -d 2018-08-16-genbank-accessions-ftp-list.tsv splits/genomes-
```

These are the files that are represented in the metadata/splits folder. This shouldn't change that often since genbank updates happen incrementally and I don't expect things to change a whole lot in a given amount of time. But this is how the metadata/list of assemblies and ftp paths and subsequently split files are created to feed into batch submission jobs to HTCondor. 