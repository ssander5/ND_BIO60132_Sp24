#!/bin/bash

#$ -M sheri.anne.sanders@gmail.com
#$ -m abe
#$ -q debug
#$ -N RunQC_A

echo "Checking for software used in this step"

echo "Checking for FastQC"

READY=1

if [[ $(which fastqc) ]]; then
   echo ".....FastQC is FOUND"
else
   echo ".....FastQC is missing"
   READY=0
fi

echo "Checking for Trimmomatic"
if [[ $(which trimmomatic) ]]; then
   echo ".....Trimmomatic is FOUND"
else
   echo ".....Trimmomatic is missing"
   READY=0
fi

echo "Checking for Sickle"

if [[ $(which sickle) ]]; then
   echo ".....Sickle is FOUND"
else
   echo ".....Sickle is missing"
   READY=0
fi

echo "Checking for BBMap"

if [[ $(which bbmap.sh) ]]; then
   echo ".....BBMap is FOUND"
else
   echo ".....BBMap is missing"
   READY=0
fi

echo "DONE Checking software"

###########################################################

echo "Checking for databases"

echo "Checking for adaptors file for trimming"
if [ -f ../Reference/adaptors.fa ]; then
    echo ".....Adaptor files exist"
else
    echo ".....Please create an adaptors.fa file in the Reference directory for trimming"
    READY=0
fi

echo "Checking for spike in file for trimming"
if [ -f ../Reference/phix_adapters.fa.gz ]; then
    echo ".....Spike in files exist"
else
    wget https://github.com/BioInfoTools/BBMap/raw/master/resources/phix_adapters.fa.gz -P ../Reference
fi


echo "Checking for rRNA database"
if [ -f ../Reference/smr_v4.3_default_db.fasta ]; then
    echo ".....rRNA database exists"
else
    wget https://github.com/sortmerna/sortmerna/releases/download/v4.3.3/database.tar.gz
    mv database.tar.gz ../Reference/
    tar xfv ../Reference/database.tar.gz --directory ../Reference/
fi

echo "Creating human reference database"

echo "Downloading and indexing genome"

   if [ -d "../Reference/human" ]; then
      echo ".....human genome already exists"
   else
      echo "pulling human reference - this could take a while"
      mkdir ../Reference/human

      curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCF_000001405.38/download?include_annotation_type=GENOME_FASTA,GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA,SEQUENCE_REPORT&filename=GCF_000001405.38.zip" -H "Accept: application/zip"
      mv GCF_000001405.38.zip  ../Reference/human
      unzip ../Reference/human/GCF_000001405.38.zip -d ../Reference/human/
      mv ../Reference/human/ncbi_dataset/data/GCF_000001405.38/GCF_000001405.38_GRCh38.p12_genomic.fna ../Reference/human/hsref_GRCh38_p12.fa
      rm ../Reference/human/GCF_000001405.38.zip
      rm -R ../Reference/human/ncbi_dataset/
      rm ../Reference/human/README.md

      wget https://downloads.sourceforge.net/project/prinseq/standalone/prinseq-lite-0.20.4.tar.gz -P ../Software
      tar xvf ../Software/prinseq-lite-0.20.4.tar.gz --directory ../Software
      rm ../Software/prinseq-lite-0.20.4.tar.gz

      #Clean
      echo "Cleaning human genome"
      perl ../Software/prinseq-lite-0.20.4/prinseq-lite.pl \
      -log \
      -verbose \
      -fasta ../Reference/human/hsref_GRCh38_p12.fa \
      -min_len 200 \
      -ns_max_p 10 \
      -derep 12345 \
      -out_good ../Reference/human/hsref_GRCh38_p12_clean \
      -seq_id hsref_GRCh38_p12_ \
      -rm_header \
      -out_bad null

      rm ../Reference/human/hsref_GRCh38_p12.fa

      #indexing the genome
      echo "Indexing human genome"
      bbmap.sh \
      ref=../Reference/human/hsref_GRCh38_p12_clean.fasta \
      path=../Reference/human
   fi

echo "DONE downloading and indexing genome!"

if [ $READY == 0 ]; then
    echo "Software or Databases are still missing, please address this before running workflow"
    echo ""
else
    echo "Software and Databases are all found, you can run the workflow now"
    echo ""
fi
