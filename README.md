# Carlie

![carlie](https://pbs.twimg.com/media/EfztMtdWsAIM4Rj?format=jpg&name=small)

## About

Written in [QtQml](https://doc.qt.io/qt-5/qmlrefrence.html), [Javascript](https://doc.qt.io/qt-5/qtqml-javascript-topic.html), [Python](https://doc.qt.io/qt-for-python) and powered by Artificial Intelligence, Carlie is a smart personal assistant for developers, primarily focused on exponetially increasing the productivity of the developer. If you know any feature you might need to make your time as a developer easier, you might as well include it in the feature section below.

## Features
* Recording daily activities
* Auto-Scheduling activities __[undone]__
* Fetch relevant contents from the web __[undone]__

# Contributing
## Setting Up
Let's get the source down to your machine and get the requirements set up. please make sure [git](https://git-scm.com) and [python](https://python.org) has been installed on your machine.

```bash
git clone https://github.com/rubbieKelvin/carlie.git
cd carlie
python -m pip install -r requirements.txt
```
The running the lines above downloads the source and then installs the project's dependencies. if everything goes right, you can now run the project on your machine with the following line.
```bash
fbs run
```

## Languages
If you know enough Javascipt, contributing to the project wouldnt be so hard for you. you'll need to know Qml too. simply put your javascript files in the `./src/main/js/` folder. and your Qml pages in the `./src/main/qml/pages/` folder.

Ensure your changes are in a new branch.

### Qt Modeling Language `[QML]`
The main qml is at `./src/main/qml/main.qml`. If you know only qml, you can contribute in building part of the project's Ui, You can create pages or components.


#### Creating a qml page.
Simply create a new qml component at `./src/main/qml/pages/`, filename's first letter should be in Caps: `./src/main/qml/pages/MyPage.qml`

Populate your new component with the following lines
```qml
import QtQuick 2.9
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9

import "../../js/main.js" as App
import "../components/" as Components

Page{
    id: root
    width: 1000
    height: 650
    title: "Page Title"

    Rectangle{
        color: "#efefef"
        anchors.fill: parent
    }
}
```
In main ui at `./src/main/qml/main.qml`. put the following node as a child of `StackLayout[id=pagestack]`. please take note of the id you give to the node.

```qml
Pages.MyPage{
    id: mypage
    width: parent.width
    height: parent.height
}
```

Append the id given to your node to the list at `Components.Navigation[id=navigation]` at `./src/main/qml/main.qml`
```qml
Components.Navigation{
    id: navigation
    pages: [..., mypage] // put your page id in the list
}
```

### Javascript
If you know little javascript, you can create logic for pages and components. you can create a new javascript file in `./src/main/js/`. To know more about Qt APIs for js, check this article.

#### Loading javascript in qml
create a file `./src/main/js/file.js`
```js
const echo = message => console.log(`you said ${message}`);
```

In your qml file; `./src/main/qml/pages/NewPage.qml`, import `./src/main/js/file.js` like so:
```qml
import QtQuick 2.0
import "../../js/file.js" as MyJsLib

Page{
    id: root
    height: 1000
    width: 100
    title: "My Page"

    Component.onCompleted: MyJsLib.echo('Hello from js')
}
```

### Python
You'll simply need the knowledge of OOP to contribute to this project using the python language. You'll mainly be building qml plugins with python.

#### Exposing python class to qml and Js
create a new python file in the `carlieqml` package at `./src/main/python/carlieqml`. lets create a new file `./src/main/python/carlieqml/myplugin.py`. 

```python
from PySide2 import QtCore

class MyPlugin(QtCore.QObject):
    def __init__(self):
        super(MyPlugin, self).__init__()

    @QtCore.Slot(str)
    def echo(self, message):
        print("[from python]:", message)
```

in `./src/main/python/main.py` create an instance of your class.

```python
# ...some imports above
from carlieqml.myplugin import MyPlugin
# ...some code below

if __name__ == '__main__':
    # ...some code above
    myplugininstance = MyPlugin()
    engine.rootContext().setContextProperty(
        "awesomeplugin", myplugininstance
    )
    # ...some code below
```
your python object has now been exposed to qml and javascript.
##### Using the exposed python object in QML.
```qml
// any qml file
// ...
Item{   // can be any qml component
    width: 10
    height: 10

    Component.onCompleted: {
        awesomeplugin.echo("hello world.");
    }
}
```

##### Using the exposed python object in Javascript
```js
// any js file
awesomeplugin.echo("hello world.");
```

if your javascript file starts with `.pragma library`, you'll have to find some other way to use the python object in the js file. here's how i do it.

```js
.pragma library

// myjsfile.js

const pythonobjects = {
    awesomeplugin: null;
};

function echowithpython(message){
    if (pythonobjects.awesomplugin === null){
        console.log("plugin is not ready");
    }else{
        pythonobjects.awesomeplugin.echo(message);
    }
}
```

your qml file would have to pass the python object to js
```qml
// any qml file
// ...
import "path/to/myjsfile.js" as MyJs

Item{   // can be any qml component
    width: 10
    height: 10

    Component.onCompleted: {
        MyJs.pythonobjects.awesomeplugin = awesomeplugin;
        MyJs.echowithpython("Hello world");
    }
}
```