import os
import glob
import codecs

os.system('touch out.wav temp.wav')
l=0
os.system('rm -rf snippets*')
for file in sorted(glob.glob("instances*.txt")):

    os.system('mkdir -p snippets{}'.format(str(l)))
    
    with codecs.open(file, 'r+', 'UTF-8') as f:
        lines_raw = f.readlines()
        lines = [x.strip().split() for x in lines_raw]
        for x in lines:
            os.system('sox ../wav/{}.wav snippets{}/{}.wav trim {} {}'.format(x[0],str(l),x[0],x[2],x[3]))
            #os.system('sox data/train/wav.scp/{}.wav snippets{}/{}.wav trim {} {}'.format(x[0],str(l),x[0],x[2],x[3]))
    l = l + 1

t = 0
s1 = None
s = None
for i in range(l):
    temp = []
    for files in (glob.glob("snippets{}/*".format(i))):
        file = files.split("/")
        temp.append(file[1])
    if t>0 :
        s1 = set(temp)
        s = s.intersection(s1)
    else:
        s = set(temp)
        t+=1

if s is None or len(s)==0:
    print("some words in the sentence does not exist or speakers are different")
else:
    f = list(s)[0]
    res = []
    for i in range(l):
        res.append("snippets{}/{}".format(i, f))
    print(res)
    print("concatenating")
    #os.system('sox {} {} speed 1.027'.format(res[0], res[0]))

    os.system("cp {} temp.wav".format(res[0]))
    os.system("cp {} out.wav".format(res[0]))
    #os.system('sox {} {} {} out.wav'.format(res[0], res[1], res[2]))
    #os.system('soxi -D out.wav')
    for i in range(l-1):
        #os.system('sox {} {} speed 1.027'.format(res[i+1], res[i+1]))
        os.system('sox temp.wav {} out.wav'.format(res[i+1]))
        os.system('cp out.wav temp.wav')
    os.system("soxi -D out.wav")
    print("Done")
