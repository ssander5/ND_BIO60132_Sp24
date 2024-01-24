#!/bin/bash

#$ -M
#$ -m abe
#$ -q debug
#$ -N RunMegaHit

#make output folder

if [ -d megahit ]; then
    echo "directory exists"
else
    mkdir megahit
fi

echo "Running megahit"

R1s=""
R2s=""
Rs=""

i=1

for f in ../clean_reads/*final.clean_1.fq; do
    R1s="$R1s,${f}"
    R2s="$R2s,${f%1.fq}2.fq"
    Rs="$Rs,${f%1.fq}u.fq"
    ((i = i + 1))
done

   megahit \
   -1 ${R1s:1} \
   -2 ${R2s:1} \
   -t 16 \
   --presets meta-large \
   --mem-flag 2 \
   -o ./megahit/
done
