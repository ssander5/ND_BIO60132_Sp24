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

echo "Removing phix adaptors and sequencing artifacts using BBMAP"


for f in ./sickle/*.trimclean.sickleclean.fq ; do
    name=${f#./sickle/}
    base=${name%_1.trimclean*}

    #bbduk for unpaired
    bbduk.sh \
    threads=8 \
    in=./sickle/${base}_1.trimclean.sickleclean.fq \
    k=31 \
    ref=../References/phix_adapters.fa.gz \
    out1=./bbmap/${base}_1.trimclean.sickleclean.spikeclean.fq \
    minlength=60 \
    2>&1 > /dev/null | awk '{print "PHIX REMOVAL UNPAIRED "$0}' | tee -a ./bbmap/${base}.stats.txt

done

echo "DONE Removing phix adaptors and sequencing artifacts using BBMAP!"

