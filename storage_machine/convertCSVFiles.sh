POSTSIDIR=/eccs/users/lmgray16/cs488/postData/copied/
POSTSODIR=/eccs/users/lmgray16/cs488/postData/converted/
PAGESIFILE=/eccs/users/lmgray16/cs488/pageData/copied/candidate_data.csv
PAGESODIR=/eccs/users/lmgray16/cs488/pageData/converted/

for file in $POSTSIDIR/*.csv
do
python3 convertPostFile.py -i $file -o $POSTSODIR
done

python3 convertPageFile.py -i $PAGESIFILE -o $PAGESODIR
