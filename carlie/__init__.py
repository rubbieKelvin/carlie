import json
from io import BufferedReader

def parse_carlie_data(file:BufferedReader) -> (list, list):
    example, target = [], []
    json_data:dict = json.load(file)
    json_data = json_data.get("intents")
    
    for key, value in json_data.items():
        value:dict

        for statement in value.get("statement"):
            example.append([statement])
            target.append(key)

    return example, target
