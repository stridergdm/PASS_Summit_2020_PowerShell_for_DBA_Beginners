$demodir="$env:HOMEDRIVE$env:HOMEPATH\OneDrive\Documents\Pass Summit 2020\Scripts"
$portnumber = 1433
$numberinstances = 4
$ver2017=@(1,2)
    $SecurePassword = get-content $demodir\cred_sa_$env:UserName.txt | ConvertTo-SecureString
    $Credential = New-Object System.Management.Automation.PSCredential ("sa", $SecurePassword)
    $passwordstring = "SA_PASSWORD=$($Credential.GetNetworkCredential().Password)"
for ($i=1; $i -le $numberinstances; $i++)
{
    $name="SQL_Demo$i"
    $portnumber += 1
    $portmapping = $portnumber.ToString()+":1433"
    if ($i -in $ver2017)
    {
        docker run --name $name -h $name -p $portmapping -e "ACCEPT_EULA=Y" -e "$passwordstring" -v C:\Docker\SQL:/sql -d mcr.microsoft.com/mssql/server:2017-latest
    }
    else
    {
        docker run --name $name -h $name -p $portmapping -e "ACCEPT_EULA=Y" -e "$passwordstring" -v C:\Docker\SQL:/sql -d mcr.microsoft.com/mssql/server:2019-latest
    }
    
}

docker ps -a