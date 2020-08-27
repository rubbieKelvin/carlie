import sys, os
from PySide2 import QtQml
from carlieqml.core import Carlie
from fbs_runtime.application_context.PySide2 import ApplicationContext


filedir = os.path.split(__file__)[0]

if __name__ == '__main__':
    os.environ["QT_QUICK_CONTROLS_STYLE"] = "Fusion"

    appctxt = ApplicationContext()       # 1. Instantiate ApplicationContext
    carlie = Carlie()

    engine = QtQml.QQmlApplicationEngine()
    engine.rootContext().setContextProperty("carlie", carlie)

    engine.load(os.path.join(filedir, "..", "qml", "main.qml"))

    exit_code = appctxt.app.exec_()      # 2. Invoke appctxt.app.exec_()
    sys.exit(exit_code)