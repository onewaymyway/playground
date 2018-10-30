import os
import shutil
import sys
import win32api

projectPath=""
jsFilePath="";
compileParam=""
jsFilePathNew=""
outLaya=False
myRoot=sys.path[0].replace("\\","/")+"/"
print(myRoot)
compileExe=myRoot+"laya.js.exe"

def getAbsPath(rpath):
    return os.path.normpath(os.path.join(myRoot,  rpath))

def copyFiles(sourceDir,  targetDir): 
    if sourceDir.find(".svn") > 0: 
        return 
    for file in os.listdir(sourceDir): 
        sourceFile = os.path.join(sourceDir,  file) 
        targetFile = os.path.join(targetDir,  file) 
        if os.path.isfile(sourceFile): 
            if not os.path.exists(targetDir):  
                os.makedirs(targetDir)  
            if not os.path.exists(targetFile) or(os.path.exists(targetFile) and (os.path.getsize(targetFile) != os.path.getsize(sourceFile))):  
                    open(targetFile, "wb").write(open(sourceFile, "rb").read()) 
        if os.path.isdir(sourceFile): 
            First_Directory = False 
            copyFiles(sourceFile, targetFile)
            
def copyFileToTar(srcFile,tarFile):
    print("copyFileToTar",srcFile,tarFile);
    if os.path.exists(srcFile):
        pass;
    else:
        print("!exitst:",srcFile)
        return;

    if os.path.isdir(srcFile):
        copyFiles(srcFile,tarFile);
    else:
        shutil.copyfile(srcFile,tarFile);

def sOpen(exe,param):
    win32api.ShellExecute(0, 'open', exe,param,'',1)

compileParam=getAbsPath("../Demo.as3proj")+";iflash=false;chromerun=false;outlaya=true";
#sOpen(compileExe,compileParam);
os.system(compileExe+" "+compileParam)
print("compile complete");
copyFileToTar(getAbsPath("../bin/h5"),getAbsPath("../../../ElectronApp/DeskPlatform/plugins/Test"))
print("copy complete")
exePath=getAbsPath("../../../Electron/EasyDesk.exe")+" "+getAbsPath("../../../ElectronApp/DeskPlatform");
print("exe:",exePath)
os.system(exePath);
print("workDone");
