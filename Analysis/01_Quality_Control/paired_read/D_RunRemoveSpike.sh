#!/bin/bash

#$ -M 
#$ -m abe
#$ -q debug
#$ -N RunQC_C

#make output folder

if [ -d ./bbmap ]; then
    echo "directory exists"
else
    mkdir bbmap
fi

echo "Removing phix adaptors and sequencing artifacts using BBMAP"


for f in ./sickle/*1.trimclean.sickleclean.fq ; do
    name=${f#./sickle/}
    base=${name%_1.trimclean*}

    #bbduk for paired
    bbduk.sh \
    threads=8 \
    in=./sickle/${base}_1.trimclean.sickleclean.fq \
    in2=./sickle/${base}_2.trimclean.sickleclean.fq \
    k=31 \
    ref=../Reference/phix_adapters.fa.gz \
    out1=./bbmap/${base}_1.trimclean.sickleclean.spikeclean.fq \
    out2=./bbmap/${base}_2.trimclean.sickleclean.spikeclean.fq \
    minlength=60 \
    2>&1 > /dev/null | awk '{print "PHIX REMOVAL PAIRED "$0}' | tee -a ./bbmap/${base}.stats.txt

    #bbduk for unpaired
    bbduk.sh \
    threads=8 \
    in=./sickle/${base}.unpaired.trimclean.sickleclean.fq \
    k=31 \
    out1=./bbmap/${base}.unpaired.trimclean.sickleclean.spikeclean.fq \
    minlength=60 \
    2>&1 > /dev/null | awk '{print "PHIX REMOVAL UNPAIRED "$0}' | tee -a ./bbmap/${base}.stats.txt

done

echo "DONE Removing phix adaptors and sequencing artifacts using BBMAP!"

