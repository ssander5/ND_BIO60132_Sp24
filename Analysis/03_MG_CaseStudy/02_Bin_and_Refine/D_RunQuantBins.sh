for f in ../clean_reads/*_1.fastq; do
    readlist="$readlist $f ${f%1.fastq}2.fastq"
done

bash mw_quant_bins.sh -b bin_refinement/metawrap_50_50_bins -o bin_quantification -a ../01_Assembly/combined/combined_1000_filtered.fasta -t 4 $readlist
