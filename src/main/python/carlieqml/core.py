import os
from . import JSON
from uuid import uuid4
from PySide2 import QtCore
from datetime import datetime

class Carlie(QtCore.QObject):
    FILEPATH = os.path.join(os.path.split(__file__)[0], ".carlie")
    FIRSTRUN = not os.path.isfile(FILEPATH)

    if FIRSTRUN:
        with open(FILEPATH, "w") as file:
            JSON(todos=[], schedule=[], ).write(file)

    firstRun = QtCore.Signal()

    def __init__(self):
        QtCore.QObject.__init__(self)

        with open(Carlie.FILEPATH) as file:
            self.data = JSON.read(file)
            self.data.schedule:list
            self.data.todos:list

        if Carlie.FIRSTRUN:
            self.firstRun.emit()

    @QtCore.Slot(result=str)
    def generateuuid(self):
        return str(uuid4())