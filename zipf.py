import numpy as np
import nltk
#import matplotlib as plt
from matplotlib import pyplot as plt

f = open('nytimes_march25.txt', 'r')

# raw = f.read().decode('utf8')
# tokens = nltk.word_tokenize(raw)
# print type(tokens)

words = [];

for line in f:
    for word in line.split():
        words.append(unicode(word,'utf-8'))

test = np.array(words)

fdist = nltk.FreqDist(test)
print(fdist)

counts = [];
idx = [];

for i in range(0,len(fdist)):
    idx.append(i+1)
    counts.append(fdist.most_common()[i][1])

print idx
print counts

plt.xscale("log")
plt.yscale("log")
plt.plot(idx,counts)
plt.show()

#print(fdist.most_common()[1][1])

# plt.yscale("log")
# fdist.plot(1000)
