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

for g in ./sickle/*trimclean.sickleclean.fq ; do
    o=${g#./sickle/}

    cp ${g%trim*}trimclean.sickleclean.fq ./bbmap/${o%trim*}trimclean.sickleclean.spikeclean.fq
done
