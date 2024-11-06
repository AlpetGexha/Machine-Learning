""" Financial Sentiment using 
hidden markob model"""
import re
import string
from decimal import Decimal
import numpy as np
import pandas as pd
# use natural language toolkit
import nltk
#import stop word
from nltk.corpus import stopwords
import math
#stemmer library import
from nltk.stem.lancaster import LancasterStemmer
# Download the 'stopwords' dataset
nltk.download('stopwords')

# Continue with the rest of the code...
# Download the 'punkt' dataset
nltk.download('punkt') # Download punkt tokenizer data
from nltk.corpus import stopwords
stop_words = set(stopwords.words('english'))

# word stemmer
stemmer = LancasterStemmer()

#encoding the csv file
import chardet
with open('/content/drive/MyDrive/class_material/Regulatory_news9a.csv', 'rb') as f:
    result = chardet.detect(f.read())  # or readline if the file is large
dataset=pd.read_csv('/content/drive/MyDrive/class_material/Regulatory_news9a.csv', encoding=result['encoding'])
#splitting thr csv file into A and y
x=dataset.iloc[:,0]
print("1. " + x)

print("---------------------------------- ")

y=dataset.iloc[:,1]
print("2. " + y)

print("---------------------------------- ")

X=x.to_dict()

#train test split 
from sklearn.model_selection import train_test_split
# X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.30, random_state = 0)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.20, shuffle=False)


print("2.5 " + y_test)

#index acending
s=y_train.reset_index()
y_train=s.iloc[:,1]
print("3. " + y_train)

print("---------------------------------- ")


#class wise data entry in training_data
training_data = []
for d in range(len(X_train)):
    #spam class training_data
    if y_train[d]=="neutral":
        training_data.append({ "class":"neutral","sentence":X_train[d]})
    #ham class training_data 
    elif y_train[d]=="positive":
        training_data.append({ "class":"positive","sentence":X_train[d]})
    else:
        training_data.append({ "class":"negative","sentence":X_train[d]})


#length of thr trainig_data  
print ("%s sentences of training data" % len(training_data))

#class dictinery
class_words = {}

# turn a list into a set (of unique items) and then a list again (this removes duplicates)
classes = list(set([a['class'] for a in training_data]))
for c in classes:
    # prepare a list of words within each class
    class_words[c] = []

#positive and negative and neutral word list creat
neu_word=[]
pos_word=[]
neg_word=[]
cr_words=[]    
for data in training_data:  
    sen=data['sentence']
    #temporarry list for appending to word list
    cr_words=[]

    print("---------------------------------- ")
    #removing digit and punctuation
    sentence= re.sub(r'\d+','',str(sen))
    print("4. " + sentence)    
    sentence= re.sub('['+string.punctuation+']', '', sentence) 
    print("5. " + sentence)
    print("---------------------------------- ")


    #neutral word lists
    if data['class']=='neutral':
        for word in nltk.word_tokenize(sentence):
            if word not in stop_words:
                stemmed_word = stemmer.stem(word.lower())
                cr_words.append(stemmed_word)
        #sentence word count   
        from collections import Counter
        count=Counter(cr_words)
        #decending by value
        w=[(l,k) for k,l in sorted([(j,i) for i,j in count.items()], reverse=True)]
        w=np.array(w)

        #just word list taken in a decinding way
        B=w[:,0]
        print("7. ")
        print (w[:,0])

        #forming a neutral word list 
        neu_word.append(B)
    elif data['class']=='positive': 
        #spam word lists
        for word in nltk.word_tokenize(sentence):
            if word not in stop_words:
                stemmed_word = stemmer.stem(word.lower())
                cr_words.append(stemmed_word)
                print("6. " + stemmed_word)
                print("---------------------------------- ")
                
        #sentence word count   
        from collections import Counter
        count=Counter(cr_words)
        w=[(l,k) for k,l in sorted([(j,i) for i,j in count.items()], reverse=True)]
        w=np.array(w)

        #just word list taken in a decinding wa
        B=w[:,0]
        print("8. ")
        print (w[:,0])

        #forming a positive word list 
        pos_word.append(B)
    else:  
        #negative word lists
        for word in nltk.word_tokenize(sentence):
            if word not in stop_words:
                stemmed_word = stemmer.stem(word.lower())
                cr_words.append(stemmed_word)
                print("6. " + stemmed_word)
                print("---------------------------------- ")
                
        #sentence word count   
        from collections import Counter
        count=Counter(cr_words)
        w=[(l,k) for k,l in sorted([(j,i) for i,j in count.items()], reverse=True)]
        w=np.array(w)

        #just word list taken in a decinding wa
        B=w[:,0]
        print("8. ")
        print (w[:,0])

        #forming a negative word list 
        neg_word.append(B)
        
          
          
          

#forming a neutral matrix
for i in range(1):
    #total list of neu_row in a column then find the max length a which will be the row dimention
    a=[]
    cl_word=neu_word
    neu_word=[]
    for j in range(len(cl_word)):
        a.append(len(cl_word[j]))
    for j in range(len(cl_word)):
        n=cl_word[j].tolist()

    
        
        #finding highest row length
        w=max(a)
        for k in range(w):
            if k==len(cl_word[j]):
                b=len(cl_word[j])+1
                #append rest of by appending to
                for l in range(b,w+1):
                    #to added cause its  in stop word 
                    n.append('None')
        neu_word.append(n)        
neu_word_matrix=np.array(neu_word)
###end forming the neutral word matrix






#forming a positive matrix
for i in range(1):
    #total list of pos_row in a column then find the max length a which will be the row dimention
    a=[]
    cl_word=pos_word
    pos_word=[]
    for j in range(len(cl_word)):
        a.append(len(cl_word[j]))
    for j in range(len(cl_word)):
        n=cl_word[j].tolist()
        #finding highest row length
        w=max(a)
        for k in range(w):
            if k==len(cl_word[j]):
                b=len(cl_word[j])+1
                #append rest of by appending to
                for l in range(b,w+1):
                    n.append('None')
        pos_word.append(n) 
#convert list to array
pos_word_matrix=np.array(pos_word)
###end forming the positive word matrix






#forming a negative matrix
for i in range(1):
    #total list of neg_row in a column then find the max length a which will be the row dimention
    a=[]
    cl_word=neg_word
    neg_word=[]
    for j in range(len(cl_word)):
        a.append(len(cl_word[j]))
    for j in range(len(cl_word)):
        n=cl_word[j].tolist()
        #finding highest row length
        w=max(a)
        for k in range(w):
            if k==len(cl_word[j]):
                b=len(cl_word[j])+1
                #append rest of by appending to
                for l in range(b,w+1):
                    n.append('None')
        neg_word.append(n) 
#convert list to array
neg_word_matrix=np.array(neg_word)
###end forming the negative word matrix








#smoothing factor
f=.15   




#states calculaton for neu_word_matrix 
neu_obs=0
for i in range(len(neu_word)):
    a=len(neu_word[i])
    for j in range(a):
        neu_obs+=1
neu_states=int((neu_obs/len(neu_word)))




#states calculaton for pos_word_matrix 
pos_obs=0
for i in range(len(pos_word)):
    a=len(pos_word[i])
    for j in range(a):
        pos_obs+=1
pos_states=int((pos_obs/len(pos_word)))




#states calculaton for neg_word_matrix 
neg_obs=0
for i in range(len(neg_word)):
    a=len(neg_word[i])
    for j in range(a):
        neg_obs+=1
neg_states=int((neg_obs/len(neg_word)))











#ith sate probabilty for any classes
def state_ith_prob(wd,cr_word,cr_word_matrix,state):
    c_R_d=[]
    count_R_d=0
    for i in range(1):
        a=len(cr_word)
        for k in range(a):
            if wd==cr_word_matrix[k][state]:
                c_R_d.append(1)
            count_R_d+=1 
    return len(c_R_d),count_R_d

#n_states probability
def state_tot_prob(wd,cr_word,cr_word_matrix):
    c_A_d=[]
    count_A_d=0
    for i in range(len(cr_word)):
        a=len(cr_word[i])
        for k in range(a):
            if wd==cr_word_matrix[i][k]:
                c_A_d.append(1)
            count_A_d+=1
    return len(c_A_d),count_A_d

#hmm model
def hmm(w,cl,state,cr_word,cr_word_matrix):
    if cl=='neutral':
        R=state_ith_prob(w,cr_word,cr_word_matrix,state)
        A=state_tot_prob(w,cr_word,cr_word_matrix)
        R_d,R_ln=R 
        A_d,A_ln=A
        score=(f*(R_d/R_ln)+(1-f)*(A_d/A_ln))
    elif cl=='positive':
        R=state_ith_prob(w,cr_word,cr_word_matrix,state)
        A=state_tot_prob(w,cr_word,cr_word_matrix)
        R_d,R_ln=R 
        A_d,A_ln=A
        score=(f*(R_d/R_ln)+(1-f)*(A_d/A_ln))
    else:
        R=state_ith_prob(w,cr_word,cr_word_matrix,state)
        A=state_tot_prob(w,cr_word,cr_word_matrix)
        R_d,R_ln=R 
        A_d,A_ln=A
        score=(f*(R_d/R_ln)+(1-f)*(A_d/A_ln))
    return score




#transition matrix for neutral
# y is transition list
y=[]
for i in range (neu_states):
    #row list appended in y
    a=[]
    for j in range (neu_states):
        #i=j+1 emitted 
        if j==i+1:
            a.append(1)
        else:
            a.append(0)
    y.append(a)
#y_list to array
neu_transition_matrix=np.array(y)





#transition matrix for positive 
# y is transition list
y=[]
for i in range (pos_states):
    #row list appended in y
    a=[]
    for j in range (pos_states):
        #i=j+1 emitted 
        if j==i+1:
            a.append(1)
        else:
            a.append(0)
    y.append(a)
#y_list to array
pos_transition_matrix=np.array(y)






#transition matrix for negative
# y is transition list
y=[]
for i in range (neg_states):
    #row list appended in y
    a=[]
    for j in range (neg_states):
        #i=j+1 emitted 
        if j==i+1:
            a.append(1)
        else:
            a.append(0)
    y.append(a)
#y_list to array
neg_transition_matrix=np.array(y)
















#learning_Rate
n=10000

#classify the test sentences

print("9. " + sentence)

def classify(sentence):
    sentence= re.sub(r'\d+','', sentence)
    sentence= re.sub('['+string.punctuation+']', '', sentence)
    sentence=sentence.lower()
    tokens=[]
    for word in nltk.word_tokenize(sentence):
        if word not in stop_words:
            stemmed_word = stemmer.stem(word.lower())
            tokens.append(stemmed_word)

    high_class = None
    high_score =0
    # loop through our classes
    for c in classes:
        # calculate score of sentence for each class
        if c=='neutral':
            alpha=0
            sum=0
            #header loop for calculating alpha_T
            for i in  range(neu_states):
                #individual word in tokens and alpha_T count
                for word in tokens:
                    #word probabilty
                    a=hmm(word,c,i,neu_word,neu_word_matrix)              
#                    print(a)
                    #sates probabilty
                    for j in range(neu_states):
                        #at first state initial probability 1
                        if 0==i:
                            r=1
                        #r after state one states probability
                        else:
                            for j in range(neu_states):
                                #emitted only i=j+1
                                sum=sum+b*(neu_transition_matrix[j][i])
                            r=sum
                    #o1,o2,......oT probability
                    b=r*a
                    #i_th probability of a sentence
                    #alpha_T at the end
                    alpha=alpha+b
            score=alpha
            score=n*(score)
        # calculate score of sentence for each class    
        elif c=='positive':
            alpha=0
            sum=0
            #header loop for calculating alpha_T
            for i in  range(pos_states):
                #individual word in tokens and alpha_T count
                for word in tokens:
                    #word probabilty  			
                    a=hmm(word,c,i,pos_word,pos_word_matrix)
                    
                    #sates probabilty
                    for j in range(pos_states):
                        if 0==i:
                            r=1
                        else:
                            for j in range(pos_states):
                                sum=sum+b*pos_transition_matrix[j][i]
                            r=sum
                    b=r*a
                    alpha=alpha+b
            #score global variable for comparision
            score=alpha
            #n smoothing factor
            score=n*(score)
        else:
            c=='negative'
            alpha=0
            sum=0
            for i in  range(neg_states):
                for word in tokens:

                    a=hmm(word,c,i,neg_word,neg_word_matrix)
                    
                    
                    for j in range(neg_states):
                        if 0==i:
                            r=1
                        else:
                            for j in range(neg_states):
                                sum=sum+b*neg_transition_matrix[j][i]
                            r=sum
                    b=r*a
                    alpha=alpha+b
            #score global variable for comparision
            score=alpha
            #n smoothing factor
            score=n*(score)     


            
            
            
        #determine class according to score
        if score > high_score:
            high_class = c
            high_score = score
    return high_class, high_score
#y_test calculation
z=[]
for j in range(len(X_test)):
    print(X_test[j])
    z.append(classify(X_test[j]))

    print(z)
    
#list to series
Z= pd.Series( (v[0] for v in z))

y_pred=Z
#confusion metrix
print("10. " + y_test)
print("11. " + y_pred)

# y_pred = float('nan')
# math.isnan(y_pred)
# if True:
#    print("---> NaN!!!")
#    y_pred = v[20]

from sklearn.metrics import confusion_matrix,accuracy_score,precision_score



cm = confusion_matrix(y_test, y_pred)
Accuracy_Score = accuracy_score(y_test, y_pred)

print("Accuracy_Score: " , Accuracy_Score)

Precision=precision_score(y_test, y_pred, average='weighted')
print("Precision_score: " , Precision)



