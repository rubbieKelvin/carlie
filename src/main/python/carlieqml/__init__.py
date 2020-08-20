import json
from io import BufferedReader, BufferedWriter

class JSON(object):
    def __init__(self, **kwargs):
        self.__kwargs__ = kwargs
        for key in kwargs:
            setattr(self, key, kwargs[key])

    def pair(self, key, value):
        self.__kwargs__[key] = value
        setattr(self, key, value)

    def __dict__(self) -> dict:
        result = dict()
        for key in self.__kwargs__:
            result[key] = getattr(self, key)
        return result

    def __str__(self) -> str:
        return json.dumps(vars(self), indent=2)

    @staticmethod
    def fromjson(jsn:str):
        """
            returns a JSON object serialized from str
        """
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
        json.dump(vars(self), fileobject, indent=2)

    def __repr__(self):
        dict_ = vars(self)
        return "<DynamicAttr {keyvalues}>".format(
            keyvalues=" ".join(
                [
                    f"{i}={dict_[i]}," for i in dict_
                ]
            ).strip(",")
        )

