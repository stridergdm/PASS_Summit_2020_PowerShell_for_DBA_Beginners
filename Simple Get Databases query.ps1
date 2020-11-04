$demodir="$env:HOMEDRIVE$env:HOMEPATH\OneDrive\Documents\Pass Summit 2020\Scripts"

$SecurePassword = get-content $demodir\cred_sa_$env:UserName.txt | ConvertTo-SecureString
$Credential = New-Object System.Management.Automation.PSCredential ("sa", $SecurePassword)
$password = $Credential.GetNetworkCredential().Password

invoke-sqlcmd -ServerInstance '.,1434' -Query 'select * from sys.databases' -username sa -Password $password

