for f in ../clean_reads/*_1.fastq; do
    readlist="$readlist $f ${f%1.fastq}2.fastq"
done

bash ./mw_binning.sh -a ../01_Assembly/combined/combined_1000_filtered.fasta -o binning -t 8 -m 20 --metabat2 --maxbin2 --concoct --run-checkm $readlist

