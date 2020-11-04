$demodir="$env:HOMEDRIVE$env:HOMEPATH\OneDrive\Documents\Pass Summit 2020\Scripts"
$SecurePassword = get-content $demodir\cred_sa_$env:UserName.txt | ConvertTo-SecureString
$Credential = New-Object System.Management.Automation.PSCredential ("sa", $SecurePassword)
$password = $Credential.GetNetworkCredential().Password

$databases = invoke-sqlcmd -ServerInstance '.,1434' -Query 'select * from sys.databases' -Username sa -Password $password

Write-Host $databases
write-Host ($databases | Format-table | Out-String)

$databases | Out-GridView


$databases | Select-Object -Property 'name','compatibility_level','collation_name'  | Write-Host
$databases | Sort-Object -Property 'name' | Select-Object -Property 'name','compatibility_level','collation_name'  | Write-Host



$databases | Sort-Object -Property 'compatibility_level' | Select-Object -Property 'name','compatibility_level','collation_name' | Where-Object {$_.compatibility_level -lt 140}| Write-Host