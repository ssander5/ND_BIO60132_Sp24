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

for g in ./bbmap/*1.trimclean.sickleclean.spikeclean.fq; do
    base=${g%_1.trim*}
    cp ${g} ${base}_1.trimclean.sickleclean.spikeclean.hostclean.fq
    cp ${base}_2.trimclean.sickleclean.spikeclean.fq ${base}_2.trimclean.sickleclean.spikeclean.hostclean.fq
    cp ${base}.unpaired.trimclean.sickleclean.spikeclean.fq ${base}.unpaired.trimclean.sickleclean.spikeclean.hostclean.fq

    echo "SKIPPING HOST CONTAMINATION SEQUENCE REMOVAL" >> ./bbmap/$(basename ${base}.stats.txt)
done
