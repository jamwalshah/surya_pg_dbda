import string
from collections import Counter

from nltk.corpus import stopwords
from nltk.tokenize import wordpunct_tokenize
from nltk.sentiment.vader import SentimentIntensityAnalyzer


text= open("read.txt",encoding="utf-8").read() 
lower_case=text.lower()
cleaned_text=lower_case.translate(maketrans('','',string.punctuation))

tokenized_words=word_tokenize(cleaned_text,'english')

final_words=[]
for word in tokenized_words:
    if word not in stopwords.words('english'):
        final_words.append(word)
print(final_words)

emotion_list=[]
with open('emotions.txt','r') as file:
    for line in file:
        clear_line=line.replace("\n",'').replace(",",'').replace("'",'').strip()
        word,emotion=clear_line.split(':')
        
        if word in final_words:
            emotion_list.append(emotion)
print(emotion_list)
w=Counter(emotion_list)
print(w)

def sentiment_analyse(sentiment_text):
    score=SentimentIntensityAnalyzer().polarity_scores(sentiment_text)
    neg=score['neg']
    pos=score['pos']
    if neg>pos:
        print("Nehative Sentiment")
    elif pos>neg:
        print("Positive sentiment")
    else:
        print("Neutral Vibe")
sentiment_analyse(cleaned_text)