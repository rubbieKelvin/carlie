import os
import json
from io import BufferedReader

CARLIEFILE = os.path.join(
    os.path.split(__file__)[0],
    "data", "carl.ie"
)

class TrainingStatement:
    def __init__(self, text, intent):
        self.text = text
        self.intent = intent

    def __repr__(self):
        return f"train_statement(text=\"{self.text}\", intent=\"{self.intent}\")"

def parse_carlie_data(file:BufferedReader) -> list:
    result = []
    json_data:dict = json.load(file)
    json_data = json_data.get("intents")
    
    for key, value in json_data.items():
        value:dict

        for statement in value.get("statement"):
            result.append(TrainingStatement(text=statement, intent=key))

    return result
