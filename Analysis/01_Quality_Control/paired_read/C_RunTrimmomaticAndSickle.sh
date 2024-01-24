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
    i2=${g%_R1*}"_R2*"                     #######IF YOUR READS ARE *R1*, please change this to %_R1* and _R2* instead of _1* and _2*
    o=${g#../../Input_data/}
    base=${o%_R1*}                     #######IF YOUR READS ARE *R1*, please change this to o%R1 instead of *_1*

    #trimmomatic pe
echo trimmomatic PE $i1 $i2 \
    -threads 16 \
    -trimlog ./trimmomatic/$base.trimlog.txt \
    ./trimmomatic/${base}_1.trimclean.fq \
    ./trimmomatic/${base}_1.u.trimclean.fq \
    ./trimmomatic/${base}_2.trimclean.fq \
    ./trimmomatic/${base}_2.u.trimclean.fq \
    ILLUMINACLIP:../Reference/adaptors.fa:1:50:30 \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:60

    #sickle pe
    echo sickle pe \
    -n \
    -f ./trimmomatic/${base}_1.trimclean.fq \
    -r ./trimmomatic/${base}_2.trimclean.fq \
    -o ./sickle/${base}_1.trimclean.sickleclean.fq \
    -p ./sickle/${base}_2.trimclean.sickleclean.fq \
    -t sanger \
    -q 20 \
    -l 60 \
    -s ./sickle/${base}_u.trimclean.sickleclean.fq

    #sickle se
    echo sickle se \
    -n \
    -f ./trimmomatic/${base}_1.trimclean.fq \
    -o ./sickle/${base}_1.unpaired.trimclean.sickleclean.fq \
    -t sanger \
    -q 20 \
    -l 60 \

    #sickle se
    echo sickle se \
    -n \
    -f ./trimmomatic/${base}_2.trimclean.fq \
    -o ./sickle/${base}_2.unpaired.trimclean.sickleclean.fq \
    -t sanger \
    -q 20 \
    -l 60 \

    #combining unpaired
    #cat ./sickle/${base}_1.u.trimclean.sickleclean.fq \
    #./sickle/${base}_2.u.trimclean.sickleclean.fq \
    #./sickle/${base}_u.trimclean.sickleclean.fq > \
    #./sickle/${base}.unpaired.trimclean.sickleclean.fq

    #rm ./sickle/${base}_1.u.trimclean.sickleclean.fq ./sickle/${base}_2.u.trimclean.sickleclean.fq ./sickle/${base}_u.trimclean.sickleclean.fq

done

echo "DONE Trimming with Trimmomatic and Sickle!"
