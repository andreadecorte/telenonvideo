#D:\Programmi\Python26\python.exe "C:\Documents and Settings\Andrea\Documenti\televideo"\install.py py2exe  
#C:\Python26\python.exe "C:\Users\Andri\Documents\televideo"\install.py py2exe
from distutils.core import setup
import py2exe, os

#the following 7 lines are an hack for PyQt 4.7 found on PyQt mailing list
dllList = ('mfc90.dll','msvcp90.dll','qtnetwork.pyd')
origIsSystemDLL = py2exe.build_exe.isSystemDLL
def isSystemDLL(pathname):
	if os.path.basename(pathname).lower() in dllList:
		return 0
	return origIsSystemDLL(pathname)
py2exe.build_exe.isSystemDLL = isSystemDLL 

setup(
    windows = [
        {
            "script": "televideo.py", 
            "icon_resources": [(0, "windows/televideo.ico")]
        }], options = 
            {   "py2exe":{"includes":["sip", "PyQt4"], 
                "excludes":["pywin", "pywin.debugger", "pywin.debugger.dbgcon", "pywin.dialogs", "pywin.dialogs.list", "Tkconstants","Tkinter","tcl"]}
				
            }
)
