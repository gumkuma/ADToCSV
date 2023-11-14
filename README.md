# ADToCSV
Convert the windows active directory data to CSV.

## Enjoy!

## For domain objects data
1. Run following powershell (.ps1) script and you will get the DomainObjects.txt file.

```
POWERSHELL> powershell -ep bypass
POWERSHELL> powershell .\DomainObjectsToTXT.ps1
```

2. Take the DomainObjects.txt file to run with the following python (.py) script and you will get the DomainObjects.csv file.

```
POWERSHELL> py DomainObjectsToCSV.py -i DomainObjects.txt -o DomainObjects.csv
```

===================================================================================

## For domain objects ACLs data
1. Run following powershell (.ps1) script and you will get the DomainObjectsACLs.txt file.

```
POWERSHELL> powershell -ep bypass
POWERSHELL> powershell .\DomainObjectsACLsToTXT.ps1
```

2. Take the DomainObjectsACLs.txt file to run with the following python (.py) script and you will get the DomainObjectsACLs.csv file.

```
POWERSHELL> py DomainObjectsACLsToCSV.py -i DomainObjectsACLs.txt -o DomainObjectsACLs.csv
```
