#list of stubs
declare -a stubs=()

for i in "${stubs[@]}"
do
#cp file into stub.hisat_and_sam.job
cp 1_hisat_and_samtools.job.blank $i.hisat_and_sam.job

#cp stub into stub.hisat_and_sam.job $stub
sed -i "s/stub=/stub=$i/g" $i.hisat_and_sam.job

#cp stub into stub.hisat_and_sam.job jobname
sed -i "s/hisat2&/hisat2_$i/1" $i.hisat_and_sam.job

done
