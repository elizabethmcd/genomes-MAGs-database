library(tidyverse)

# hug genomes list
hug = read.csv("metadata/Hug2016-genomes-proks.csv")
colnames(hug) = c("organism", "ncbi", "jgi")

# all genbank metadata
genbank = read.csv("metadata/2019-08-15-all-genbank-genomes.csv")
gbk = genbank %>% select(X.Organism.Name, BioSample, BioProject, Assembly)

# refseq complete metadata
refseq = read.csv("metadata/refseq-complete-bacterial-genomes.csv")
refs = refseq %>% select(Organism.Name, BioSample, BioProject, Assembly, Replicons)
noreplicons = refs %>% select(Organism.Name, Assembly, BioSample, BioProject)
clean = sub(".*:(.*)/.*", "\\1", refs$Replicons)
clean2 = sub(".*:(.*);.*", "\\1", clean)
clean3 = sub(".*:(.*)", "\\1", clean2)
rid = sub("(.*).1", "\\1", clean3)
combined = cbind(noreplicons, rid)
colnames(combined) = c("organism_name", "assembly", "BioSample", "BioProject", "ncbi")

# hug select biosamples
biosamp = hug %>% select(organism, ncbi) %>% filter(str_detect(ncbi, "SAMN"))
colnames(biosamp) = c("organism", "BioSample")

# hug select bioprojects 
bioproj = hug %>% select(organism, ncbi) %>% filter(str_detect(ncbi, "PRJ"))
colnames(bioproj) = c("organism", "BioProject")

# hug nc and nz refseqs
nc = hug %>% select(organism, ncbi) %>% filter(str_detect(ncbi, "NC"))
nz = hug %>% select(organism, ncbi) %>% filter(str_detect(ncbi, "NZ"))

# merge with metdata
samp_meta = left_join(biosamp, gbk)
proj_meta = left_join(bioproj, gbk)  # not a lot of bioproject numbers provided
nc_meta = left_join(nc, combined)
nz_meta = left_join(nz, combined)

# get rid of nas 
samps = na.omit(samp_meta)
ncs = na.omit(nc_meta)
nzs = na.omit(nz_meta)

# reorder cols to merge with total 
nc_ordered = ncs %>% select(organism, assembly, BioSample, BioProject)
nz_ordered = nzs %>% select(organism, assembly, BioSample, BioProject)
samps_ordered = samps %>% select(organism, Assembly, BioSample, BioProject)
colnames(samps_ordered) = c("organism", "assembly", "BioSample", "BioProject")

# merge back with total hug data to get missing columns of weird replicon accessions given
merged = rbind(nc_ordered, nz_ordered, samps_ordered)
fin = left_join(hug, merged)
colnames(fin) = c("organism", "hug_ncbi", "hug_jgi", "assembly", "BioSample", "BioProject")

# write out
write.csv(fin, "metadata/2019-12-04-Hug2016-automatic-genbank-accessions-assignments.csv", row.names = FALSE, quote = FALSE )
