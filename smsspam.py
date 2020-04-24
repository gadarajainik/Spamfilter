import flask
from flask import request

from sklearn.feature_extraction.text import CountVectorizer
from sklearn.externals import joblib
import numpy as np
import pandas as pd
import nltk
from nltk.corpus import stopwords
import string
from scipy.sparse import csr_matrix

app = flask.Flask(__name__)
app.config['SECRET_KEY'] = 'topnotch'
app.config["DEBUG"] = True

# logic starts

nltk.download('stopwords')


def process(text):
    nopunc = [char for char in text if char not in string.punctuation]
    nopunc = ''.join(nopunc)

    clean_words = [word for word in nopunc.split() if word.lower()
                   not in stopwords.words('english')]

    return clean_words


def checker(passedVal):
    msg = passedVal
    messages = []
    messages.append(msg)
    msgs = pd.DataFrame(messages, columns=['sms'])
    bowch = CountVectorizer(analyzer=process).fit_transform(msgs['sms'])
    retVal = "Ham"
    try:
        bowch = CountVectorizer(analyzer=process).fit_transform(msgs['sms'])
    except ValueError:
        retVal = "Ham"

    # joblib.dump(classifier, "spamDetector.pkl")
    classifier = joblib.load("spamDetector.pkl")
    bowchnp = bowch.toarray()
    np0 = np.zeros((1, 11425-bowchnp.shape[1]))
    final = np.concatenate((bowchnp, np0), axis=1)
    finalcsr = csr_matrix(final)
    if (classifier.predict(finalcsr)[0] == 0):
        retVal = "Ham"
    else:
        retVal = "Spam"

    return retVal

# logic ends


@app.route('/', methods=['GET'])
def home():
    return checker(request.args['msg'])


app.run()
