import json
from io import BufferedReader, BufferedWriter

class JSON(object):
    def __init__(self, **kwargs):
        self.__kwargs__ = kwargs
        for key in kwargs:
            setattr(self, key, kwargs[key])

    def __str__(self):
        return json.dumps(self.__kwargs__, indent=2)

    @staticmethod
    def fromjson(jsn:str):
        jsn = json.loads(jsn)
        if type(jsn) == dict:
            return JSON(**jsn)
        raise TypeError("json did not serialize to a dict")

    @staticmethod
    def read(fileobject:BufferedReader):
        data = json.load(fileobject)
        if type(data) == dict:
            return JSON(**data)
        raise TypeError("json did not serialize to a dict")

    def write(self, fileobject:BufferedWriter):
        json.dump(self.__kwargs__, fileobject, indent=2)

