# CS 753- Assignment-1
## Team Details:
Team name: Tenacious Tomatoes

Team members-
Sl. | Name             | Roll Number
| -------------- | :--------- | ----------:
1  | Sunaina Saxena     | 213070001
2  | Harsh Diwakar      | 213070018
3  | B. Govardhan Reddy | 213070008

## Task-1:
Files in 1A:
1. L.arpa: Trigram Language Model in arpa format
2. create-LM.sh : Takes vocab.txt as input and creates a language model fst, L.fst from L.arpa
3. create_words_in_LM.py: Python script to save the words in language model into a text file
4. fill.sh: Takes an incomplete sentance and adds one word to complete the sentance
5. minn.py: Helper Python script for fill.sh
6. sent.py: Helper function for create sentance task in 1B
    
Files in 1B:
1. create-sent.sh: accepts four (space-separated) words w1, w2, w3,
w4 and produces a most probable 7 word sentance.

## Task-2
run.sh is assumed to be kept inside [kaldi]/egs/wolof directory.

Files in 2A:
1. train_mono.sh: Contains the tuned parameters for monophone model.
2. wer.txt: Contains the word error rate for monophone model on the test set
train_mono.sh is assumed to be kept inside [kaldi]/egs/wsj/s5/steps directory.

Files in 2B:
1. wer.txt: Contains the word error rate for triphone model on the test set

Files in 2C: 
1. wer.txt: Contains the word error rate for data augmented model on the test set

Files in 2D:
1. basic-tts.sh: It will take a sentence as argument and outputs the out.wav that is the audio clips of a particular speaker if the words in the sentence exists in the dataset.
2. clips.py: Helper function for basic-tts.sh
2D folder is assumed to kept inside the [kaldi]/egs/wolof directory.
