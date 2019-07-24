#! /bin/bash

for filename in */*.faa; 
    do GENNAME=`basename ${filename%.faa}`; 
    sed "s|^>|>${GENNAME}_|" $filename; 
    done > combined-prots.faa