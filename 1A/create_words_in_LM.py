import argparse
import os

parser = argparse.ArgumentParser()
parser.add_argument('v', type = str, nargs = '+')
parse = parser.parse_args()

my_f = open("words.txt","r")
new_f = open("words_in_LM.txt","w")
content = my_f.read().split()
wrr = []
for i in range(0,len(content),2):
	if (content[i] != "<eps>" and content[i] != "<s>" and content[i] !="</s>" and content[i] != "<unk>"):
		new_f.write("{}\n".format(content[i]))

new_f.close()
my_f.close()


