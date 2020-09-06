import os
import chatterbot
from chatterbot.trainers import ChatterBotCorpusTrainer

class Carlie(chatterbot.ChatBot):
    """Carlie PA class
    """

    def __init__(self, **kwargs):

        # default options for carlie
        options = dict(
            storage_adapter='chatterbot.storage.SQLStorageAdapter',
            database_uri='sqlite:///carlie.database.db',
            logic_adapters=[
                'chatterbot.logic.BestMatch',
                "carlie.logic.PersonalAILogicAdapter"
            ],
            preprocessors=[
                "carlie.preprocessors.classify_statement"
            ],
            carlie_data_file=os.path.join(
                os.path.split(__file__)[0],
                "data", "carlie_data.json"
            )
        )

        # update options
        options.update(kwargs)

        # call the parent"s constructor
        super(Carlie, self).__init__("Carlie", **options)

        # train chatbot
        ChatterBotCorpusTrainer(self).train(
            "chatterbot.corpus.english.greetings",
            "chatterbot.corpus.english.emotion"
        )