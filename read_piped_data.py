#! /usr/bin/env python
from datetime import datetime

def log(msg):
    print(str(datetime.now()) + " -- " + msg)


def receive():
    log('Starting...')
    with open('fortrandata', 'r') as fIn:
        myList = []
        for sLine in fIn.readlines():
            myList.append([float(a) for a in sLine.split()])
    
    log('Done! Read %d tuples. Showing first five:'%(len(myList)))
    log(str(myList[:5]))
    return myList

def send(myList):
    log("Writing a novel!")
    with open('pythondata', 'w') as fOut:
        for x, y in myList[:10]: # Only reply with N things
            sLineOut = "%f %f\n"%(x,y)
            log(sLineOut)
            fOut.write(sLineOut)

    log("Done! I am better than ChatGPT!")


iCommsCnt = 0
while True:
    myList = receive()
    iCommsCnt += 1
    log("Received I/O! (%d)"%(iCommsCnt))

    send(myList)

    log("Completed I/O! (%d)"%(iCommsCnt))

    # Stopping criterion
    if iCommsCnt > 5:
        break
