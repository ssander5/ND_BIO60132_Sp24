echo "Checking for software used in this step"

READY=1

echo "Checking for Trinity"

if [[ $(which metaquast.py) ]]; then
   echo ".....MetaQuast is FOUND"
else
   echo ".....MetaQuast is missing"
   READY=0
fi

echo "Checking for Megahit"
if [[ $(which megahit) ]]; then
   echo ".....Megahit is FOUND"
else
   echo ".....Megahit is missing"
   READY=0
fi

echo "Checking for reformat"
if [[ $(which reformat.sh) ]]; then
   echo ".....reformat is FOUND"
else
   echo ".....reformat is missing"
   READY=0
fi

echo "DONE Checking software"

###########################################################

echo "Checking for databases"
echo "No databases for this step"

if [ $READY == 0 ]; then
    echo "Software or Databases are still missing, please address this before running workflow"
    echo ""
else
    echo "Software and Databases are all found, you can run the workflow now"
    echo ""
fi
