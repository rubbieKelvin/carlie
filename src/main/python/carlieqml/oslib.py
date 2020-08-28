import os
import json
from PySide2 import QtCore

class Os(QtCore.QObject):
    def __init__(self):
        """
        qml plugin mimicing basic python os module 
        """
        super(Os, self).__init__()

    @QtCore.Slot(result=str)
    def environ(self):
        return json.dumps(
            dict(os.environ)
        )