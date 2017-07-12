# Set path to hats
$path_to_hats = "$env:PROGRAMFILES\hats"

echo "Adding hats ($path_to_hats) path to environment variables"
[Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$path_to_hats", "Machine")

echo "Create robot folder in $path_to_hats"
If(!(test-path $path_to_hats))
{
	New-Item -ItemType Directory -Force -Path "$env:PROGRAMFILES\hats"
}

$user = "$env:UserDomain\$env:UserName"
echo "Setting permisions for user $user"

$Folders = Get-childItem $path_to_hats -attributes D
$InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit -bor [System.Security.AccessControl.InheritanceFlags]::ObjectInherit
$PropagationFlag = [System.Security.AccessControl.PropagationFlags]::None
$objType = [System.Security.AccessControl.AccessControlType]::Allow

$acl = Get-Acl "$path_to_hats"
$permission = $user,"Modify", $InheritanceFlag, $PropagationFlag, $objType
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
Set-Acl -Path "$path_to_hats" -AclObject $acl
