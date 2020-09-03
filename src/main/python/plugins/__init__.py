from PySide2 import QtCore

def pluginlabel(className:QtCore.QObject, name:str) -> tuple:
    return className, "Carlie.Plugins", 1, 0, name