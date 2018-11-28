#!/usr/bin/env python
"""
Very simple HTTP server in python.
Usage::
    ./dummy-web-server.py [<port>]
Send a GET request::
    curl http://localhost
Send a HEAD request::
    curl -I http://localhost
Send a POST request::
    curl -d "foo=bar&bin=baz" http://localhost
"""

import os
import cgi
import http
import threading
import json
import os
import shutil
import sys
import re
import win32api
from socketserver import ThreadingMixIn
from http.server import BaseHTTPRequestHandler, HTTPServer, SimpleHTTPRequestHandler

myRoot=sys.path[0].replace("\\","/")+"/"
print(myRoot)
userRoot=os.path.normpath(os.path.join(myRoot,  "user"))
userConfig={}
tokenDic={}

class UserClient():

    def __init__(self,userName):
        self.user=userName
        self.rootPath=os.path.normpath(os.path.join(userRoot,  userName))
        
    def getFiles(self,folder):
        tfolder=self.getPath(folder)
        print("getFiles:",tfolder)
        rst={}
        rst["root"]=folder
        rst["childs"]=[]
        if os.path.exists(tfolder):
            files=os.listdir(tfolder)
            
            rst["childs"]=files
            for file in files:
                print(file)
        return rst
        

    def getPath(self,rpath):
        return os.path.normpath(os.path.join(self.rootPath,  rpath))

    def deleteFile(self,fPath):
        fPath=self.getPath(fPath)
        print("deleteFile:",fPath)
        if os.path.exists(folder):
            os.remove(folder)
            return True

    def addFile(self,fPath,content):
        fPath=self.getPath(fPath)
        print("addFile:",fPath)
        folder=os.path.dirname(fPath)
        if not os.path.exists(folder):
            os.makedirs(folder)
        writeFile(fPath,content)

    def getFile(self,fPath):
        fPath=self.getPath(fPath)
        #print("getFile:",fPath)
        if os.path.exists(fPath):
            #print("fileExists")
            return readFile(fPath)
        return None
    

class CORSRequestHandler(SimpleHTTPRequestHandler):
    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/json')
        self.send_header('Access-Control-Allow-Origin', '*')
        SimpleHTTPRequestHandler.end_headers(self)
        # self.end_headers()
    def do_GET(self):
        self._set_headers()
        self.wfile.write(("<html><body><h1>mini Python Server is working</h1></body></html>").encode())

    def do_POST(self):

        form = cgi.FieldStorage(self.rfile,
        headers=self.headers,
        environ={'REQUEST_METHOD':'POST',
                 'CONTENT_TYPE':"multipart/form-data;",})

        # 获取 POST 过来的 Value
        value = form.getvalue("key")
        action=form.getvalue("action")
        token=form.getvalue("token")
        self._set_headers()
        #print(form)

        if action=="login":
            self.do_login(form)
            return

        userData=self.getUserDataByToken(token)
        if userData==None:
            return;

        if action=="getFileList":
            self.sendSuccess(userData.getFiles(form.getvalue("path")))
        elif action=="getFile":
            datas=userData.getFile(form.getvalue("path"))
            print("getFile datas:",datas)
            dataO={}
            if datas==None:
                dataO["success"]=False
            else:
                dataO["success"]=True
                dataO["content"]=datas
            self.sendSuccess(dataO)
        elif action=="addFile":
            userData.addFile(form.getvalue("path"),form.getvalue("content"))
            self.sendSuccess({})

        
        #self.wfile.write(value.encode())

    def do_OPTIONS(self):
        form = cgi.FieldStorage()
        print(form)
        self.send_response(200,"ok")
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Headers','X-Requested-With')
        self.send_header('Access-Control-Allow-Headers','Content-Type')
        self.end_headers()


    def sendJson(self,data):
        self.wfile.write(json.dumps(data).encode("utf-8"))


    def sendErr(self,msg):
        data={}
        data["msg"]=msg
        data["success"]=False
        self.sendJson(data)

    def sendSuccess(self,dataO):
        data={};
        data["data"]=dataO;
        data["success"]=True
        self.sendJson(data)

    def getUserDataByToken(self,token):
        userData=getUserByToken(token)
        if userData==None:
            self.sendErr("need login")
            return
        return userData

        
    def do_login(self,form):
        username=form.getvalue("username")
        pwd=form.getvalue("pwd")
        print("do_login:",username,pwd)
        if not username in userConfig:
            self.sendErr("user not found")
        if not userConfig[username]==pwd:
            self.sendErr("pwd wrong")

        rst={};
        rst["token"]=getTokenForUser(username)
        tokenDic[rst["token"]]=UserClient(username)
        self.sendSuccess(rst)
        


class ThreadedHTTPServer(ThreadingMixIn, HTTPServer):
    """ This class allows to handle requests in separated threads.
        No further content needed, don't touch this. """


def run(server_class=HTTPServer, handler_class=CORSRequestHandler, port=8081):
    initConfigs()
    server_address = ('', port)
    httpd = ThreadedHTTPServer(server_address, handler_class)
    print('Starting httpd on 8081...')
    httpd.serve_forever()

def readFile(path):
    f=open(path,encoding="utf-8")
    res=f.read()
    f.close()
    return res

def readJsonFile(path):
    return json.loads(readFile(path))

def writeFile(path,content):
    fw =open(path,'w',encoding='utf-8')
    fw.write(content)
    fw.close()

def writeJsonFile(path,dataO):
    writeFile(path,json.dumps(dataO))

def getAbsPath(rpath):
    return os.path.normpath(os.path.join(myRoot,  rpath))

def getTokenForUser(username):
    token="666666"
    return token

def getUserByToken(token):
    if token in tokenDic:
        return tokenDic[token]
    return None

def initConfigs():
    global userConfig
    userConfig=readJsonFile("user/userinfo.json")
    print("userConfig:",userConfig)

if __name__ == "__main__":
    from sys import argv
    if len(argv) == 2:
        run(port=int(argv[1]))
    else:
        run()
