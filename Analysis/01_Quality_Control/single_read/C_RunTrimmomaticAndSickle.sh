#!/bin/bash

#$ -M 
#$ -m abe
#$ -q debug
#$ -N RunQC_C

#make output folder

if [ -d trimmomatic ]; then
    echo "directory exists"
else
    mkdir trimmomatic
fi

if [ -d sickle ]; then
    echo "directory exists"
else
    mkdir sickle
fi

echo "Trimming with Trimmomatic and Sickle"

for g in ../../../Input_data/*_R1*; do    #######IF YOUR READS ARE *R1*, please change this to *R1* instead of *_1*
    i1=$g
    o=${g#../../../Input_data/}
    base=${o%_R1*}                     #######IF YOUR READS ARE *R1*, please change this to o%R1 instead of *_1*
    echo $base

    trimmomatic SE $i1 \
    -threads 16 \
    -trimlog ./trimmomatic/$base.trimlog.txt \
    ./trimmomatic/${base}_1.trimclean.fq \
    ILLUMINACLIP:../References/adaptors.fa:1:50:30 \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:60

    #sickle se
    sickle se \
    -n \
    -f ./trimmomatic/${base}_1.trimclean.fq \
    -o ./sickle/${base}_1.trimclean.sickleclean.fq \
    -t sanger \
    -q 20 \
    -l 60 \

done

echo "DONE Trimming with Trimmomatic and Sickle!"
