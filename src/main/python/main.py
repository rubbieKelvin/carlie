from fbs_runtime.application_context.PySide2 import ApplicationContext

from PySide2 import QtQml

import sys, os

__filedir__ = os.path.split(__file__)[0]

if __name__ == '__main__':
    appctxt = ApplicationContext()       # 1. Instantiate ApplicationContext

    engine = QtQml.QQmlApplicationEngine()
    engine.load(os.path.join(__filedir__, "..", "qml", "main.qml"))

    exit_code = appctxt.app.exec_()      # 2. Invoke appctxt.app.exec_()
    sys.exit(exit_code)