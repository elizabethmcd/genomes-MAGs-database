#! /bin/bash

for file in */*.faa; do
    N=$(basename $file .faa);
    sed 's/\s.*$//' $file > $N/$N.faa.fixed;
done


