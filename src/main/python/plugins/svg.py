import os
from plugins import svg
from PySide2 import QtCore
import xml.dom.minidom as dom

class Svg(QtCore.QObject):
    PREFIX = "data:image/svg+xml;utf8, "
    ROOT = os.path.split(__file__)[0]

    def __init__(self):
        super(Svg, self).__init__()
        self._source = None         # filename
        self._svg_string = None     # *<svg ...></svg>

    sourceChanged = QtCore.Signal()

    def get_source(self):
        return self._source if self._source else ""

    def set_source(self, source):
        self._svg_string = None     # reset the svg string
        self._source = source
        self.sourceChanged.emit()

    def get_svg_string(self):

        if self._svg_string: return self._svg_string
        if not self._source: return Svg.PREFIX+"<svg></svg>"
        
        with open(os.path.join(Svg.ROOT, self._source)) as file:
            string = file.read()
        
        return Svg.PREFIX+string

    @QtCore.Slot(str, str, str)
    def setAttr(self, tag, key, value):
        if not self._source: return

        with open(os.path.join(Svg.ROOT, self._source)) as file:
            tree = dom.parse(file)
        tree:dom.Element = tree.childNodes[0]

        eld = tree.getElementsByTagName(tag)

        el:dom.Element
        for el in eld:
            el.setAttribute(key, value)

        self._svg_string = Svg.PREFIX+tree.toxml()
        self.sourceChanged.emit()

    source = QtCore.Property(str, get_source, set_source, notify=sourceChanged)
    sourceData = QtCore.Property(str, get_svg_string, notify=sourceChanged)