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

for g in ./bbmap/*1.trimclean.sickleclean.spikeclean.hostclean.fq; do
    base=${g%_1.trim*}
    cp ${base}_1.trimclean.sickleclean.spikeclean.hostclean.fq ${base}_1.final.clean.fq
    cp ${base}_2.trimclean.sickleclean.spikeclean.hostclean.fq ${base}_2.final.clean.fq
    cp ${base}.unpaired.trimclean.sickleclean.spikeclean.hostclean.fq ${base}_u.final.clean.fq

    echo "SKIPPING rRNA CONTAMINATION REMOVAL" >> ./bbmap/$(basename ${base}.stats.txt)
done
