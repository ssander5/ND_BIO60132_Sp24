#!/bin/bash

#$ -M
#$ -m abe
#$ -q debug
#$ -N RunQC_D

#make output folder

if [ -d ./bbmap ]; then
    echo "directory exists"
else
    mkdir bbmap
fi

echo "SKIPPING Removing phix adaptors and sequencing artifacts using BBMAP"

if [ -d ./bbmap ]; then
    echo "directory exists"
else
    mkdir bbmap
fi

echo "SKIPPING Removing phix adaptors and sequencing artifacts using BBMAP"

for g in ./sickle/*1.trimclean.sickleclean.fq ; do
    o=${g#./sickle/}
    base=${o%_1.trim*}

    cp ./sickle/${base}_1.trimclean.sickleclean.fq ./bbmap/${base}_1.trimclean.sickleclean.spikeclean.fq
    cp ./sickle/${base}_2.trimclean.sickleclean.fq ./bbmap/${base}_2.trimclean.sickleclean.spikeclean.fq
    cp ./sickle/${base}.unpaired.trimclean.sickleclean.fq ./bbmap/${base}.unpaired.trimclean.sickleclean.spikeclean.fq
done
