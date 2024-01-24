#!/bin/bash

#$ -M sheri.anne.sanders@gmail.com
#$ -m abe
#$ -q debug
#$ -N RunSpades

#make output folder

if [ -d spades ]; then
    echo "directory exists"
else
    mkdir spades
fi

echo "Running spades"

#   spades.py --pe1-1 lib1_forward_1.fastq --pe1-2 lib1_reverse_1.fastq \
#   --pe1-1 lib1_forward_2.fastq --pe1-2 lib1_reverse_2.fastq \
#   -o spades_output

echo "Making YAML file"
echo "[" > spades.yaml
echo "  {" >> spades.yaml
echo '    orientation: "fr",' >> spades.yaml
echo '    type: "paired-end",' >> spades.yaml
echo '    right reads: [' >> spades.yaml

wd=`pwd`
path=${wd%01_Assembly}

for f in ../clean_reads/*final.clean_1.fq*; do
    echo "      \"${path}clean_reads/$(basename ${f})\"," >> spades.yaml
done

truncate -s-2 spades.yaml  #remove last ,

echo "" >> spades.yaml
echo '    ],' >> spades.yaml
echo '    left reads: [' >> spades.yaml

for f in ../clean_reads/*final.clean_2.fq*; do
    echo "      \"${path}clean_reads/$(basename ${f})\"," >> spades.yaml
done
truncate -s-2 spades.yaml  #remove last ,

echo "" >> spades.yaml
echo '    ]' >> spades.yaml
echo '  }' >> spades.yaml
echo ']' >> spades.yaml

spades.py --meta -k auto -o ./spades -t 16 --dataset spades.yaml
