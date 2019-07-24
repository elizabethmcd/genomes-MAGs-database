#! /bin/bash

for filename in */*.fixed; 
    do GENNAME=`basename ${filename%.faa.fixed}`; 
    sed "s|^>|>${GENNAME}_|" $filename; 
    done > combined-prots.faa