# Create txt file for creating fst
cd "$(dirname "$0")"
touch temp.txt
# insert start in txt file
arr=""
arr+="0 1 <s>"
echo -e "$arr">temp.txt
# Loop through all the words before xxx and create fst
i=2
j=$#
while [ $i -le $j ]
do
	pa="$((i-1)) $((i)) $1"
	echo "$pa">>temp.txt
	i=$((i+1))
	shift 1;
done
# add all the words from vocabulary in language model to fst
input=words_in_LM.txt
while IFS= read -r line
do
	echo -e "$((i-1)) $i $line">>temp.txt
done < "$input"
# add end of the sentence
i=$((i+1))
echo "$((i-1)) $((i)) </s>">>temp.txt
echo -e "$((i))">>temp.txt
# Compile txt file into fst
fstcompile --acceptor=true --isymbols=words.txt --osymbols=words.txt temp.txt F.fst
# Find the shortest path
k=$(fstcompose F.fst L.fst | fstshortestpath | fstprint --osymbols=words.txt)
# Print the most probable word
python3 minn.py $k
rm temp.txt
