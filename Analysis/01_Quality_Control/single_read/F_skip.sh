#!/bin/bash

#$ -M
#$ -m abe
#$ -q debug
#$ -N RunQC_F

#make output folder

if [ -d bbmap ]; then
    echo "directory exists"
else
    mkdir bbmap
fi

#Get Database

echo "SKIPPING Removing rRNA contamination using SortMeRNA database in bbduk"

for g in ./bbmap/*trimclean.sickleclean.spikeclean.hostclean.fq; do

    cp ${g%trim*}trimclean.sickleclean.spikeclean.hostclean.fq ${g%trim*}final.clean.fq

    echo "SKIPPING rRNA CONTAMINATION REMOVAL" >> ./bbmap/$(basename ${g%trim*}stats.txt)
done
