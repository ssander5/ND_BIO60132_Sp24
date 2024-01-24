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

echo "Removing host contamination and generating stats using BBMAP"

for f in ./bbmap/*trimclean.sickleclean.spikeclean.fq; do
    base=${f%_1.trim*}

    bbwrap.sh \
    threads=16 \
    minid=0.95 \
    maxindel=3 \
    bwr=0.16 \
    bw=12 \
    quickmatch \
    fast \
    minhits=2 \
    qtrim=rl \
    trimq=20 \
    minlength=60 \
    in=$f,${base}_1.trimclean.sickleclean.spikeclean.fq \
    outu1=${base}_1.trimclean.sickleclean.spikeclean.hostclean.fq \
    path=../References/human 2>&1 >/dev/null | \
    awk '{print "HOST CONTAMINATION SEQUENCES "$0}' | \
    tee -a ./bbmap/$(basename ${base}.stats.txt)
done

echo "DONE Removing host contamination and generating stats using BBMAP!"
