$demodir="$env:HOMEDRIVE$env:HOMEPATH\OneDrive\Documents\Pass Summit 2020\Scripts"
$SecurePassword = get-content $demodir\cred_sa_$env:UserName.txt | ConvertTo-SecureString
$Credential = New-Object System.Management.Automation.PSCredential ("sa", $SecurePassword)
$password = $Credential.GetNetworkCredential().Password

$serverport=1433
for ($i=1; $i -le $numberinstances; $i++)
{
    
    invoke-sqlcmd -ServerInstance ".,$($serverport+$i)"  -Username sa -Password $password -Query "Create Database Pass_Demo_$i"
    invoke-sqlcmd -ServerInstance ".,$($serverport+$i)"  -Username sa -Password $password -Query "alter Database Pass_Demo_$i set recovery Full"
    invoke-sqlcmd -ServerInstance ".,$($serverport+$i)"  -Username sa -Password $password -Query "Create login SA_$i with Password= 'Thisis%secure$i'"
    invoke-sqlcmd -ServerInstance ".,$($serverport+$i)"  -Username sa -Password $password -Query "ALTER SERVER ROLE sysadmin ADD MEMBER SA_$i"

    invoke-sqlcmd -ServerInstance ".,$($serverport+$i)"  -Username sa -Password $password -Query "Create Database Pass_Demo_120_$i"
    invoke-sqlcmd -ServerInstance ".,$($serverport+$i)"  -Username sa -Password $password -Query "alter Database Pass_Demo_120_$i Set compatibility_level = 120"

}



