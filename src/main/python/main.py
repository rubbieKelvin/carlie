import os, sys
from PySide2 import QtQml, QtCore
from fbs_runtime.application_context.PySide2 import ApplicationContext

import plugins
from plugins import svg

if __name__ == '__main__':
    os.environ["QT_QUICK_CONTROLS_STYLE"] = "Material"
    appctxt = ApplicationContext()       # 1. Instantiate ApplicationContext
    engine = QtQml.QQmlApplicationEngine()

    # Register Python Plugin
    svg.Svg.ROOT = os.path.split(__file__)[0]
    QtQml.qmlRegisterType(*plugins.pluginlabel(svg.Svg, "UiSvg"))

    engine.load(QtCore.QUrl(
        os.path.join(
            os.path.split(__file__)[0],
            "qtquick", "carlie.qml"
        )
    ))

    exit_code = appctxt.app.exec_()      # 2. Invoke appctxt.app.exec_()
    sys.exit(exit_code)