import nltk

from . import CARLIEFILE
from . import parse_carlie_data

from sklearn import svm
from chatterbot.conversation import Statement
from sklearn.feature_extraction.text import CountVectorizer


# open carlie file
with open(CARLIEFILE) as file:
    data = parse_carlie_data(file)

# training examples and target
train_x = [x.text for x in data]
train_y = [x.intent for x in data]

# text vectorizer (bag of words)
vectorizer = CountVectorizer()
train_x_vectors = vectorizer.fit_transform(train_x)

# classifier model
classifier = svm.SVC(kernel="linear")
classifier.fit(train_x_vectors, train_y)


def classify_statement(statement:Statement) -> Statement:

    """preprocessor for classifying texts before
    they are sent to logical adapters
    """

    test_vector = vectorizer.transform(
        [statement.text]
    )

    intent = classifier.predict(test_vector)[0]

    setattr(statement, "intent", intent)
    return statement