import os
from . import JSON
from PySide2 import QtCore

class Carlie(QtCore.QObject):

    FILEPATH = os.path.join(os.path.split(__file__)[0], ".carlie")
    FIRSTRUN = not os.path.isfile(FILEPATH)
    if FIRSTRUN:
        with open(FILEPATH, "w") as file:
            JSON(todos=[], schedule=[], ).write(file)

    firstRun = QtCore.Signal()


    def __init__(self):
        super(Carlie, self).__init__()
        with open(Carlie.FILEPATH) as file:
            self.data = JSON.read(file)

        if Carlie.FIRSTRUN:
            self.firstRun.emit()
