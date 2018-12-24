import requests
import json
import os
import time
import shutil
import sys
import re

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

def getTypes():
    url="https://zhimap.com/restful/pub/syscat/list_count"
    dataO={}


    cookies={}
    cookies["pgv_pvi"]="8508949504"
    cookies["SSID"]="9b9d271c-32de-4305-9f8c-96538e9c3d79"
    cookies["pgv_si"]="s6418127872"

    res=requests.get(url,dataO,cookies=cookies)
    jsonO=json.loads(res.text)
    types=jsonO["data"]
    del types[0]

    for typeO in types:
        print(typeO["title"])
    #print(types)
    return types
def getPage(typeO,page):
    url="https://zhimap.com/restful/pub/publication/list"
    dataO={}
    dataO["categoryUuid"]=typeO["uuid"]
    dataO["recommend"]=0
    dataO["page"]=page
    dataO["size"]=20


    cookies={}
    cookies["pgv_pvi"]="8508949504"
    cookies["SSID"]="9b9d271c-32de-4305-9f8c-96538e9c3d79"
    cookies["pgv_si"]="s6418127872"

    res=requests.get(url,dataO,cookies=cookies)
    jsonO=json.loads(res.text)
    
    return jsonO["data"]

def getOKStr(text):
    pat = re.compile('(?<=\>).*?(?=\<)')
    rst= ''.join(pat.findall(text))
    rstr = r"[\/\\\:\*\?\"\<\>\|]"  # '/ \ : * ? " < > |'
    rst = re.sub(rstr, "_", rst)  # 替换为下划线
    return rst

def saveMindMap(mindMap):
    trees=mindMap["trees"]
    title=trees[0]["title"]
    title=getOKStr(title)
    title=title.replace("/","_")
    jsonStr=json.dumps(trees)
    #jsonStr=getOKStr(jsonStr)
    filepath=getPath("files/"+title+".zmap")
    print(title,filepath)
    writeFile(filepath,jsonStr)
    
def workPageFiles(files):
    for tfile in files:
        saveMindMap(tfile["mindMap"])
        
def getTypePages(typeO):
    first=getPage(typeO,0)
    workPageFiles(first["content"])
    totalPage=first["totalPages"]
    if totalPage==1:
        return

    for i in range(0,totalPage):
        dataO=getPage(typeO,i+1)
        workPageFiles(dataO["content"])
    

def work():
    types=getTypes()
    #getTypePages(types[0])
    for typeO in types:
        getTypePages(typeO)

#getTypes()

work()
