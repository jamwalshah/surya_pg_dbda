
import nltk
from nltk.stem import PorterStemmer
from nltk.corpus import stopwords
nltk.download('punkt')
nltk.download('wordnet')
nltk.download('omw-1.4') #Open Multilingual Wordnet lexical database that provides word meanings
# and relationships in various languages. 
import re

#stopwords.words('english')
paragraph="""I have three visions for India. In 3000 years of our history
             people from all over the world have come and invaded us,
             captured our lands,conquered our minds. From Alexander onwards the Greeks, 
             the Turks, the Moguls, the Portuguese, the British, the French, the Dutch, 
             all of them came and looted us, took over what was ours. Yet we have not done
             this to any other nation.We have not conquered anyone. We have not grabbed 
             their land, their culture and their history and tried to enforce our way of 
             life on them. Why? Because we respect the freedom of others. 
             That is why my FIRST VISION is that of FREEDOM. I believe that India got
             its first vision of this in 1857, when we started the war of Independence.
             It is this freedom that we must protect and nurture and build on.
             If we are not free, no one will respect us.
             We have 10 percent growth rate in most areas. Our poverty levels are falling.
             Our achievements are being globally recognised today.
             Yet we lack the self-confidence to see ourselves as a developed nation,
             self-reliant and self-assured. Isn’t this incorrect? MY SECOND VISION for India
             is DEVELOPMENT. For fifty years we have been a developing nation.
             It is time we see ourselves as a developed nation. We are among top
             five nations in the world in terms of GDP.
             I have a THIRD VISION. India must stand up to the world.
             Because I believe that unless India stands up to the world, no one will respect us.
             Only strength respects strength. We must be strong not only as a military
             power but also as an economic power. Both must go hand-in-hand. 
             My good fortune was to have worked with three great minds. Dr.Vikram Sarabhai,
             of the Dept. of Space, Professor Satish Dhawan, who succeeded him 
             and Dr. Brahm Prakash, father of nuclear material. I was lucky to have worked
             with all three of them closely and consider this the great opportunity of my
             life.I see four milestones in my career """

sentences=nltk.sent_tokenize(paragraph)
stemmer=PorterStemmer() 
stemmer.stem('history')

from nltk.stem import WordNetLemmatizer
lemmatizer=WordNetLemmatizer()
lemmatizer.lemmatize('history')
#cleaning data
corpus=[]
for i in range(len(sentences)):
    review=re.sub('[^a-zA-Z]',' ',sentences[i])
    review=review.lower()
    corpus.append(review)
for i in corpus:
    words=nltk.word_tokenize(i)
    for word in words:
        if word not in set(stopwords.words('english')):
            print(stemmer.stem(word))
        
#LEMMATIZATION
corpus=[]
for i in  range(len(sentences)):
    review=re.sub('[^a-zA-Z]',' ',sentences[i])
    review=review.lower()
    review=review.split() #get each and evey sentences
    review=[lemmatizer.lemmatize(word) for word in review if not word in set(stopwords.words('english'))]
    review=' '.join(review)
    corpus.append(review)
    
    
    
 
#BAG OF WORDS
from sklearn.feature_extraction.text import CountVectorizer
cv=CountVectorizer() #default binary=False ngram_range=(2,3)#bigram and trigram
X=cv.fit_transform(corpus)
cv.vocabulary_ #all words with index number(feature number not frequency)
corpus[0]
X[0].toarray()


#GloVec
import gensim
import gensim.downloader as api
glove_model=api.load('glove-wiki-gigaword-300')
glove_model.most_similar('love',topn=10)

#husband-man+woman=?
glove_model.most_similar(positive=['woman','husband'],negative=['man'],topn=1)

____________________________________________________________
import gensim
from sklearn.manifold import TSNE

my_vocab = ['apple','orange','shimla','banana','maruti','mumbai','china','india','husband'
            ,'wife','brother','sister','red','yellow','computer','mobile','pear','guava']

words = []
vectors = []


for word in my_vocab:
    words.append(word)
    vectors.append(glove_model[word])

print(vectors)
print(words)
dicts = zip(words,vectors)


import pandas as pd
df1=pd.DataFrame.from_dict(dicts)

dim_model = TSNE(n_components=2, perplexity=3, init='pca', random_state=45)



fit_model = dim_model.fit_transform(vectors)



import matplotlib.pyplot as plt



fit_model




x = []
y = []

for i in fit_model:
    x.append(i[0])
    y.append(i[1])


plt.figure(figsize=(8,8))

for i in range(len(x)):
    plt.scatter(x[i],y[i])
    plt.annotate(words[i], xy=(x[i],y[i]),
                 xytext=(2, 2),
                 textcoords='offset points',
                 ha='right',
                 va='bottom'
                )
