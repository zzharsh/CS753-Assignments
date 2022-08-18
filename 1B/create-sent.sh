# Create txt file for creating fst
cd "$(dirname "$0")"
# Assuming all the files created in 1A are present in the 1A directory
cd ../1A
touch temp.txt
# Function for inserting all the elements
LM () {
	input=words_in_LM.txt
	while IFS= read -r line
	do
	echo -e "$1 $2 $line">>temp.txt
	# we are not using self loops (shown in red in the jpg file) because 
	#then there will be infinite states after composing 
	#and the system will not work
	# But if it were to be implemented the below line will do that
	
	#echo -e "$1 $1 $line">>temp.txt
done < "$input"
}
# Function for normal states
NM () {
	echo -e "$1 $2 $3">>temp.txt
}
# State-0
echo -e "0 1 <s>">temp.txt
echo -e "0 4 <s>">>temp.txt
echo -e "0 6 <s>">>temp.txt
echo -e "0 3 <s>">>temp.txt
# 3
LM 3 4
LM 3 6
LM 3 1
# 1
echo -e "1 2 $1">>temp.txt
echo -e "1 14 $1">>temp.txt
echo -e "1 18 $1">>temp.txt
echo -e "1 22 $1">>temp.txt
echo -e "1 24 $1">>temp.txt
echo -e "1 27 $1">>temp.txt
echo -e "1 29 $1">>temp.txt
# 2
LM 2 14
LM 2 18
LM 2 22
LM 2 24
LM 2 27
LM 2 29
# 4
echo -e "4 5 $3">>temp.txt
echo -e "4 10 $3">>temp.txt
echo -e "4 16 $3">>temp.txt
echo -e "4 25 $3">>temp.txt
# 5
LM 5 10
LM 5 16
LM 5 25
# 6
echo -e "6 7 $4">>temp.txt
echo -e "6 8 $4">>temp.txt
echo -e "6 12 $4">>temp.txt
echo -e "6 20 $4">>temp.txt
# 7
LM 7 8
LM 7 12
LM 7 20

# 8
echo -e "8 9 $3">>temp.txt
echo -e "8 30 $3">>temp.txt
# 9
LM 9 30
#10
echo -e "10 30 $4">>temp.txt
echo -e "10 11 $4">>temp.txt
#11
LM 11 30
#12
NM 12 13 $1
NM 12 32 $1
# 13
LM 13 32
#14
NM 14 15 $4
NM 14 32 $4
#15
LM 15 32
# 16
NM 16 17 $1
NM 16 34 $1
#17
LM 17 34
#18
NM 18 34 $3
NM 18 19 $3
#19
LM 19 34
# 20
NM 20 21 $1
NM 20 51 $1
# 21
LM 21 51
# 22
NM 22 51 $4
NM 22 23 $4
# 23
LM 23 51 
# 24
NM 24 52 $2
NM 24 37 $2
# 52
LM 52 37
# 25
NM 25 26 $1
NM 25 39 $1
# 26
LM 26 39
# 27
NM 27 39 $3
NM 27 28 $3
# 28
LM 28 39
# 29
NM 29 41 $2
NM 29 53
# 53
LM 53 41

# 30
NM 30 43 $1
NM 30 31 $1
# 31
LM 31 43
# 32
NM 32 43 $3
NM 32 33 $3
# 33
LM 33 43
# 34
NM 34 43 $4
NM 34 35 $4
# 35
LM 35 43
# 51
NM 51 36 $2
NM 51 45 $2
# 36
LM 36 45
# 37
NM 37 45 $4
NM 37 38 $4
# 38
LM 38 45
# 39
NM 39 47 $2
NM 41 40 $2
# 40
LM 40 47
# 41
NM 41 47 $3
NM 41 42 $3
# 42
LM 42 47

# 43
NM 43 44 $2
NM 43 49 $2
# 44
LM 44 49
# 45
NM 45 49 $3
NM 45 46 $3
# 46
LM 46 49
# 47
NM 47 48 $4
NM 47 49 $4
# 48
LM 48 49

# 49
echo -e "49 50 </s>">>temp.txt
# 50
echo -e "50">>temp.txt

#Condition 1: w2 should come after w1
fstcompile --acceptor=true --isymbols=words.txt --osymbols=words.txt temp.txt C1.fst

# Condition 2: All words should come and sentance length 7
echo -e "0 1 <s>">temp.txt
LM 1 2
LM 2 3
LM 3 4
LM 4 5
LM 5 6
LM 6 7
LM 7 8
echo -e "8 9 </s>">>temp.txt
echo -e "9">>temp.txt
fstcompile --acceptor=true --isymbols=words.txt --osymbols=words.txt temp.txt C2.fst
fstcompose C1.fst C2.fst T.fst
rm C1.fst
rm C2.fst
rm temp.txt
# Find the shortest path
k=$(fstcompose T.fst L.fst | fstshortestpath | fstprint --osymbols=words.txt)
python3 sent.py $k

