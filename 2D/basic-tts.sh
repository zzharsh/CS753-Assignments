#!bin/bash

text=$1
echo $#
l=0
cd ..
steps/get_train_ctm.sh data/train lang exp/tri1
cd 2D
rm -rf instances*.txt
for i in $text
do
    grep -w $i ../exp/tri1/ctm > instances${l}.txt
    l=$((l + 1))
done
python3 clips.py
