import os, json
from PySide2 import QtCore

class Storage(QtCore.QObject):
    def __init__(self, filename=None, default=dict()):
        super(Storage, self).__init__()
        self._default = default
        self.filename = filename if filename else ".store"
        self.load()

    dataDestroyed = QtCore.Signal()

    def save(self):
        """save storage file
        """
        with open(self.filename, "w") as file:
            json.dump(self._dict, file, indent=2)

    def load(self):
        """load storage file to dictionary
        """
        if not os.path.isfile(self.filename):
            self._dict = self._default
            with open(self.filename, "w") as file:
                json.dump(self._dict, file, indent=2)
            return

        with open(self.filename) as file:
            self._dict = json.load(file)
    
    @QtCore.Slot()
    def destroy(self):
        """ delete storage file
        """
        os.remove(self.filename)
        self.dataDestroyed.emit()

    @QtCore.Property(bool, notify=dataDestroyed)
    def destroyed(self) -> bool:
        """checks if storage file is destroyed
        """
        return not os.path.isfile(self.filename)
