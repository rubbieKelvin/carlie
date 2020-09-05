from chatterbot import ChatBot
from chatterbot.trainers import ChatterBotCorpusTrainer

from .trainers import CarlieTrainer


class Carlie(ChatBot):
    def __init__(self, db_uri="sqlite:///carlie.pa.db"):
        super(Carlie, self).__init__(
            "Carlie",
            storage_adapter="chatterbot.storage.SQLStorageAdapter",
            logical_adapters=[
                'chatterbot.logic.MathematicalEvaluation',
                'chatterbot.logic.TimeLogicAdapter',
                'chatterbot.logic.BestMatch'
            ],
            database_uri=db_uri,
            preprocessors=[
                "chatterbot.preprocessors.clean_whitespace",
                "carlie_ai.preprocessors.lower"
            ]
        )

        _corpus_trainer = ChatterBotCorpusTrainer(self)
        _corpus_trainer.train(
            "chatterbot.corpus.english.ai",
            "chatterbot.corpus.english.botprofile",
            "chatterbot.corpus.english.computers",
            "chatterbot.corpus.english.conversations",
            "chatterbot.corpus.english.emotion",
            "chatterbot.corpus.english.food",
            "chatterbot.corpus.english.greetings",
            "chatterbot.corpus.english.health",
            "chatterbot.corpus.english.history",
            "chatterbot.corpus.english.humor",
            "chatterbot.corpus.english.money",
            "chatterbot.corpus.english.psychology",
            "chatterbot.corpus.english.science",
        )

        _carlie_trainer = CarlieTrainer(self)
        _carlie_trainer.train()
