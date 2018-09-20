import os
import shutil
import sys
import win32api

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

def copyAtlas(sourceFolder,tarFolder):
    print("copyAtlas")
    atlasList=["view","comp","play"]
    for atlas in atlasList:
        copyFileToTar(sourceFolder+atlas+".json",tarFolder+atlas+".json")
        copyFileToTar(sourceFolder+atlas+".png",tarFolder+atlas+".png")

def copySkinFiles(skinName):
    global atlasSourceFolder
    global projectPath
    atlasTarFolder=IDEPath+"resources/app/out/vs/layaEditor/h5/skins/"+skinName+"/"
    copyAtlas(atlasSourceFolder,atlasTarFolder)
    copyFileToTar(projectPath+"laya/styles.xml",atlasTarFolder+"styles.xml")
    
myPath=os.getcwd()
print(myPath)
userDir=os.path.join(myPath,  "datatemp")
os.system('"C:/Program Files (x86)/Google/Chrome/Application/chrome.exe" --disable-web-security --remote-debugging-port=9222 --user-data-dir='+userDir)

#http://localhost:9222/json
print("workDone");
