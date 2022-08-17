c=$1

cd "$(dirname "$0")"
touch words.txt

# Please make sure arpa2fst and kaldi command can be run from this folder
# Create fst from arpa language model
arpa2fst L.arpa L.fst
# Save the table for further use
fstprint --save_isymbols=words.txt L.fst temp.txt
# Save all the words in language model for future use
python3 create_words_in_LM.py words.txt
rm temp.txt

