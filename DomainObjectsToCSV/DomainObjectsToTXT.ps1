$domainObj = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
$PDC = $domainObj.PdcRoleOwner.Name
$DN = ([adsi]'').distinguishedName
$LDAP = "LDAP://$PDC/$DN"
$direntry = New-Object System.DirectoryServices.DirectoryEntry($LDAP)
$dirsearcher = New-Object System.DirectoryServices.DirectorySearcher($direntry)
$result = $dirsearcher.FindAll()
$outputFilePath = ".\DomainObjects.txt"

foreach ($obj in $result) {
    foreach ($prop in $obj.Properties.PropertyNames) {
        $propertyName = $prop
        $propValue = $obj.Properties[$propertyName]

        # Construct a string with property name and value
        $output = "$propertyName`t{$propValue}"
        $output | Out-File -Append -FilePath $outputFilePath
    }
    "-------------------------------" | Out-File -Append -FilePath $outputFilePath
}