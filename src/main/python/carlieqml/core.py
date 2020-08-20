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
        super(Carlie, self).__init__()
        with open(Carlie.FILEPATH) as file:
            self.data = JSON.read(file)
            self.data.schedule:list
            self.data.todos:list

        if Carlie.FIRSTRUN:
            self.firstRun.emit()

    def datetimefromjs(self, datestr:str):
        """
            values from javascript Date object can be turned to python's datetime.datetime object here
            // js
            let date = new Date().toJSON();
            
            // python
            Carlie().datefromjs(date) # date would have to be passed btw languages 
        """
        date, time = datestr.split("T")
        time = time.split(".")[0]
        year, month, day = [int(i) for i in date.split("-")]
        hour, minute, second = [int(i) for i in time.split(":")] 
        return datetime(year, month, day, hour, minute, second) 

    @QtCore.Slot(str, result=bool)
    def newschedule(self, json):
        """
            json should be a dict type containg {
                id: uuid4 \\ None
                from=str(DateTime) : time you want to start performing this action,
                to=str(DateTime) : time you want to stop performing this action,
                activity=str  : what you want to do exactly,
                text=str : text description,
            }
        """
        data = JSON.fromjson(json)
        data.pair("id", str(uuid4()))
        self.data.schedule.append(vars(data))
        with open(Carlie.FILEPATH, "w") as file:
            self.data.write(file)
        
        return True
        