import argparse
import re

def getColumn():
    fi = open(inputFile,"r")
    columnList = ["name","adspath","ActiveDirectoryRights","IdentityReference","AccessControlType","InheritanceType"]
    for x in fi:
        regexColumn = re.search("^(\\S+)\\s+\\x7b",x)
        if regexColumn:
            if regexColumn[1] not in columnList:
                columnList.append(regexColumn[1])
            #print(regexColumn[1])
        else:
            if "{" in x:
                print("______________Regex Fail_______________",x)
    #print("ColumnList: ", columnList)
    fi.close()
    return columnList

def generateCSV(columnList):
    fo = open(outputFile,"a")
    csvHeader = ""
    for column in columnList:
        csvHeader = csvHeader+"\""+column.replace("\"","\"\"")+"\","
    fo.write(csvHeader+"\n")
    
    fi = open(inputFile,"r")
    data = {}
    for x in fi:
        if x == "-------------------------------\n":
            csvRecord = ""
            for column in columnList:
                if column in data:
                    csvRecord = csvRecord+"\""+data[column].replace("\"","\"\"")+"\","
                else:
                    csvRecord = csvRecord+"\"\""+","
            fo.write(csvRecord+"\n")
            data.clear()
        else:    
            regexData = re.search("^(\\S+)\\s+\\x7b([^\\x7d]+)\\x7d",x)
            if regexData:
                data[regexData[1]] = regexData[2]
            else:
                if "{" in x:
                    print("______________Regex Fail_______________",x)
    
parser = argparse.ArgumentParser()
parser.add_argument('-i', type=str, default="DomainObjs.txt", required=True, help="Input file ex. DomainObjs.txt")
parser.add_argument('-o', type=str, default="DomainObjs.csv", required=True, help="Output file ex. DomainObjs.csv")
args = parser.parse_args()
inputFile = args.i
outputFile = args.o
print('Input File: ', inputFile)
print('Output File: ', outputFile)
columnList = getColumn()
#print(columnList)
generateCSV(columnList)