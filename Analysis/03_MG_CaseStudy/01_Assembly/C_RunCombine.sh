#!/bin/bash

#$ -M
#$ -m abe
#$ -q debug
#$ -N RunCombine

#make output folder

if [ -d combined ]; then
    echo "directory exists"
else
    mkdir combined
fi

echo "Combining Assemblies"

cat ./spades/scaffolds_1000_filtered.fasta megahit/megahit_final_1000_filtered.fasta > combined/combined.fasta

echo "Dereplicating Assemblies"
cd-hit-est -i combined/combined.fasta -o combined/combined.nr.fasta -c 1.00 -T 8

echo "DONE combining"
