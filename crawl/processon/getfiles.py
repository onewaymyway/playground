import requests
import json
import os
import time
import shutil
import sys

myRoot=sys.path[0].replace("\\","/")+"/"
print(myRoot)


def getPath(rpath):
    return os.path.normpath(os.path.join(myRoot,  rpath))

def addFolder(fPath):
    fPath=getPath(fPath)
    folder=fPath
    if not os.path.exists(folder):
        os.makedirs(folder)
    
def writeFile(path,content):
    fw =open(path,'w',encoding='utf-8')
    fw.write(content)
    fw.close()
    
def getPage(page):
    url="https://www.processon.com/diagrams/query_clone_chart"
    dataO={}
    dataO["cate"]=""
    dataO["keyword"]=""
    dataO["status"]="temp-system"
    dataO["tag"]=""
    dataO["curPage"]=page
    dataO["sortKey"]="cloneCount"
    dataO["paysort"]="all"
    dataO["usid"]="5c08f2b6e4b00a7052cddbe0"

    cookies={}
    cookies["usid"]="5c08f2b6e4b00a7052cddbe0"

    res=requests.post(url,dataO,cookies=cookies)
    jsonO=json.loads(res.text)
    return jsonO

def getDataByDefID(defID):
    url="https://www.processon.com/diagraming/getdef"
    dataO={}
    dataO["tempId"]="5c090a12e4b0c87510c33612"
    dataO["id"]=defID
    dataO["_"]="1544096143431"

    cookies={}
    cookies["usid"]="5c08f2b6e4b00a7052cddbe0"

    res=requests.get(url,dataO,cookies=cookies)
    jsonO=json.loads(res.text)
    return jsonO

def getAndSaveFile(title,defID,category):
    dataO=getDataByDefID("5af424dde4b0219b16d5dbe3")
    txt=dataO["def"]
    rootFolder="files/"+category
    addFolder(rootFolder)
    filePath=rootFolder+"/"+title+".pso"
    writeFile(filePath,txt)
    
def parseOnePage(pageO):
    items=pageO["data"]
    for tPage in items:
        print(tPage["title"],tPage["definitionId"],tPage["category"])
        getAndSaveFile(tPage["title"],tPage["definitionId"],tPage["category"])

def work():
    tpage=1
    while True:
        print("workpage:",tpage)
        pageO=getPage(tpage)
        #print(pageO)
        parseOnePage(pageO)
        if pageO["more"]:
            pass
        else:
            return
        tpage=tpage+1

#dataO=getDataByDefID("5af424dde4b0219b16d5dbe3")
#print(dataO)

#getAndSaveFile("haha","5af424dde4b0219b16d5dbe3","tt")

work()
