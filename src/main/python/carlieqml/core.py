import os, json
from uuid import uuid4
from PySide2 import QtCore
from datetime import datetime

class Carlie(QtCore.QObject):
    FILEPATH = os.path.join(os.path.split(__file__)[0], ".crl")
    FIRSTRUN = not os.path.isfile(FILEPATH)

    if FIRSTRUN:
        with open(FILEPATH, "w") as file:
            json.dump(dict(
                application=dict()
            ), file, indent=2)

    firstRun = QtCore.Signal()

    def __init__(self):
        QtCore.QObject.__init__(self)

        with open(Carlie.FILEPATH) as file:
            self.data = json.load(file)

        if Carlie.FIRSTRUN:
            self.firstRun.emit()

    @QtCore.Slot(result=str)
    def generateuuid(self):
        return str(uuid4())

    @QtCore.Slot(str)
    def savejson(self, jstring:str):
        self.data.update(json.loads(jstring))

        with open(Carlie.FILEPATH, "w") as file:
            json.dump(self.data, file, indent=2)

    @QtCore.Slot(result=str)
    def getData(self):
        return json.dumps(self.data)