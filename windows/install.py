#C:\Programmi\Python26\python.exe "C:\Documents and Settings\Dree\Desktop\televideo"\install.py py2exe  
from distutils.core import setup
import py2exe

setup(
    windows = [
        {
            "script": "televideo.py", 
            "icon_resources": [(0, "televideo.ico")]
        }], options = 
            {   "py2exe":{"includes":["sip", "PyQt4"], 
                "excludes":["pywin", "pywin.debugger", "pywin.debugger.dbgcon", "pywin.dialogs", "pywin.dialogs.list", "Tkconstants","Tkinter","tcl"]}
				
            }
)
