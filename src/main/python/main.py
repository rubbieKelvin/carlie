import os, sys
from PySide2 import QtQml, QtCore
from fbs_runtime.application_context.PySide2 import ApplicationContext

import json
import plugins
from plugins import svg
from plugins import storage

class CarlieStorage(storage.Storage):
    def __init__(self):
        super(CarlieStorage, self).__init__(filename=".store", default=dict(
            todos=list(),
            settings=dict(
                theme="Light"
            )
        ))

    settingsUpdated = QtCore.Signal()
    todoAdded       = QtCore.Signal(str)

    @QtCore.Slot(str, result=str)
    def getSetting(self, key):
        res = self._dict["settings"].get(key)
        if key=="*": res = self._dict["settings"]
        
        return json.dumps(res)

    @QtCore.Slot(str, str)
    def pairSetting(self, key:str, value:str):
        """key is string,
        value is json string
        """
        self._dict["settings"][key] = json.loads(value)
        self.settingsUpdated.emit()

    @QtCore.Slot(str)
    def new_todo(self, tododata:str):
        """
        tododata:jsonstr = {
            title: str,
            description: str,
            notify: bool
            notify_time: int  # 
            theme: color
        }
        """

if __name__ == '__main__':
    os.environ["QT_QUICK_CONTROLS_STYLE"] = "Material"
    appctxt = ApplicationContext()       # 1. Instantiate ApplicationContext
    engine = QtQml.QQmlApplicationEngine()

    # Register Python Plugin: Svg
    svg.Svg.ROOT = os.path.split(__file__)[0]
    QtQml.qmlRegisterType(*plugins.pluginlabel(svg.Svg, "UiSvg"))

    # Register Python Plugin: Storage
    store = CarlieStorage()
    engine.rootContext().setContextProperty("storage", store)

    engine.load(QtCore.QUrl(
        os.path.join(
            os.path.split(__file__)[0],
            "qtquick", "carlie.qml"
        )
    ))

    if not engine.rootObjects():
        sys.exit(-1)

    exit_code = appctxt.app.exec_()      # 2. Invoke appctxt.app.exec_()
    sys.exit(exit_code)