$demodir="$env:HOMEDRIVE$env:HOMEPATH\OneDrive\Documents\Pass Summit 2020\Scripts"

$SecurePassword = get-content $demodir\cred_sa_$env:UserName.txt | ConvertTo-SecureString
$Credential = New-Object System.Management.Automation.PSCredential ("sa", $SecurePassword)
$password = $Credential.GetNetworkCredential().Password

if (test-path $demodir\logins.csv)
{
    remove-item  -path $demodir\logins.csv 
}
$instances = @('.,1434','.,1435','.,1436','.,1437')

foreach ($instance in $instances)
{
    
    $results = invoke-sqlcmd -ServerInstance $instance -Username sa -Password $password -query "select '$instance' as Instance, name, is_disabled, is_policy_checked, is_expiration_checked from sys.sql_logins where is_disabled=0"
    
    write-host "$instance - Has the following sql_logins enabled: $($results.name)"
    $results |  convertTo-csv -NoTypeInformation | out-file -filepath $demodir\logins.csv -Append
 
}
