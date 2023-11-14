$domainObj = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
$PDC = $domainObj.PdcRoleOwner.Name
$DN = ([adsi]'').distinguishedName
$LDAP = "LDAP://$PDC/$DN"
$direntry = New-Object System.DirectoryServices.DirectoryEntry($LDAP)
$dirsearcher = New-Object System.DirectoryServices.DirectorySearcher($direntry)
$result = $dirsearcher.FindAll()
$outputFilePath = ".\DomainObjectsACLs.txt"

foreach ($obj in $result) {
	if ($obj.Properties.Contains("distinguishedName")){
		$cadspath = $obj.Properties["adspath"]
		$objName = $obj.Properties["name"]
		$ldapPath = "$cadspath"
		$adObject = [ADSI]$ldapPath
		$acl = $adObject.psbase.ObjectSecurity
		$accessRules = $acl.GetAccessRules($true, $false, [System.Security.Principal.NTAccount])
		foreach ($rule in $accessRules) {
			"adspath`t{$cadspath}" | Out-File -Append -FilePath $outputFilePath
			"name`t{$objName}" | Out-File -Append -FilePath $outputFilePath
			foreach ($property in $rule.PSObject.Properties) {
				$output = "$($property.Name)`t{$($property.Value)}"
				$output | Out-File -Append -FilePath $outputFilePath
			}
			"-------------------------------" | Out-File -Append -FilePath $outputFilePath
		}
	}

}