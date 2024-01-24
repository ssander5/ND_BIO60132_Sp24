#!/bin/bash

#$ -M
#$ -m abe
#$ -q debug
#$ -N RunQC_E

#make output folder

if [ -d bbmap ]; then
    echo "directory exists"
else
    mkdir bbmap
fi

echo "SKIPPING Removing host contamination and generating stats using BBMAP"

for g in ./bbmap/*trimclean.sickleclean.spikeclean.fq; do

    cp $g ${g%trim*}trimclean.sickleclean.spikeclean.hostclean.fq

    echo "SKIPPING HOST CONTAMINATION SEQUENCE REMOVAL" >> ./bbmap/$(basename ${g%trim*}stats.txt)
done
