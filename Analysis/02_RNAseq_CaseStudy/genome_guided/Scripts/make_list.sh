cp make_1.sh make_1.listed.sh
cp make_2.sh make_2.listed.sh

#for use with _R1.fastq formatting:
#sed -i "s/()/$(ls -lAh ../Clean_Reads/ | sed 1d | awk '{print $9}' | sed 's/_R[12].*$//g' | sort | uniq | tr '\n' '&' | sed -e 's/&/" "/g' -e 's/^/("/g' -e 's/ "$/)/g')/g" make_1.listed.sh
#sed -i "s/()/$(ls -lAh ../Clean_Reads/ | sed 1d | awk '{print $9}' | sed 's/_R[12].*$//g' | sort | uniq | tr '\n' '&' | sed -e 's/&/" "/g' -e 's/^/("/g' -e 's/ "$/)/g')/g" make_2.listed.sh

#for use with _1.fastq formatting:
sed -i "s/()/$(ls -lAh ../Clean_Reads/ | sed 1d | awk '{print $9}' | sed 's/_[12].*$//g' | sort | uniq | tr '\n' '&' | sed -e 's/&/" "/g' -e 's/^/("/g' -e 's/ "$/)/g')/g" make_1.listed.sh
sed -i "s/()/$(ls -lAh ../Clean_Reads/ | sed 1d | awk '{print $9}' | sed 's/_[12].*$//g' | sort | uniq | tr '\n' '&' | sed -e 's/&/" "/g' -e 's/^/("/g' -e 's/ "$/)/g')/g" make_2.listed.sh
