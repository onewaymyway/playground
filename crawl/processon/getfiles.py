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
    #dataO["tempId"]=defID
    dataO["id"]=defID
    #dataO["id"]="595b44c7e4b0c2773f847d68"
    dataO["_"]="1544096143431"

    cookies={}
    cookies["usid"]="5c08f2b6e4b00a7052cddbe0"
    cookies["zg_did"]="%7B%22did%22%3A%20%2216782f0a715282-09ca2ff95e6ed4-43480420-1fa400-16782f0a717535%22%7D"
    cookies["JSESSIONID"]="7CB0D73CF374A5B74FA3A3A1DE216CD6.jvm1"
    cookies["processon_referrer"]="https%3A//www.baidu.com/link%3Furl%3DsFSW8UxZGaX_borVh1uQmRNvR4jn93oE9JNIfyxfIGtiGdegWxPgo9V1dRFVycr4%26wd%3D%26eqid%3D8aa35ba700039be1000000025c08f250"
    cookies["_ga"]="GA1.2.402341674.1544090069"
    cookies["_gid"]="GA1.2.187908568.1544090069"

    res=requests.get(url,dataO,cookies=cookies)
    #print(res.text)
    jsonO=json.loads(res.text)
    return jsonO

def getAndSaveFile(title,defID,category):
    dataO=getDataByDefID(defID)
    #print(dataO)
    if not "def" in dataO:
        print("failErr:",dataO)
        return
    txt=dataO["def"]
    rootFolder="files/"+category
    addFolder(rootFolder)
    filePath=rootFolder+"/"+title+".pso"
    writeFile(filePath,txt)
    
def parseOnePage(pageO):
    items=pageO["data"]
    for tPage in items:
        print(tPage["title"],tPage["definitionId"],tPage["category"])
        getAndSaveFile(tPage["title"],tPage["chartId"],tPage["category"])

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

#getAndSaveFile("haha","595b44c7e4b0c2773f847d68","tt")

work()
