from chatterbot.trainers import Trainer

class CarlieTrainer(Trainer):
    def __init__(self, chatbot, **kwargs):
        super(CarlieTrainer, self).__init__(chatbot, **kwargs)

    def train(self, *args, **kwargs):
        pass