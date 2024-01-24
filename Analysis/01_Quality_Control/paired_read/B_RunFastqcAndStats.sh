#!/bin/bash

#$ -M 
#$ -m abe
#$ -q debug
#$ -N RunQC_B

echo "Running FastQC and Generating Stats"

#make output folder
if [ -d "fastqc" ]; then
    echo "./fastqc exists"
else
    mkdir fastqc
fi

for g in ../../../Input_data/*fastq.gz; do
      fastqc -o ./fastqc $g
done


echo "DONE Running FastQC and Generating Stats!"
