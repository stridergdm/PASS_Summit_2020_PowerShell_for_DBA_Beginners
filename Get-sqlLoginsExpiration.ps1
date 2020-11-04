$demodir="$env:HOMEDRIVE$env:HOMEPATH\OneDrive\Documents\Pass Summit 2020\Scripts"

$instances_json=get-content -Raw -path (join-path -Path $demodir -ChildPath serverlist.json) | ConvertFrom-Json



$LookbackDays = 180
$i=1
foreach ($instance in $instances_json)
{
    $password = "Thisis%secure$i"
    $username = "SA_$i"
    $results =  Invoke-Sqlcmd -ServerInstance $instance.Server -Username $username -Password $password -query "SELECT '$($instance.Server)' as Server, '$($instance.Environment)' as Env, name, LOGINPROPERTY([name], 'PasswordLastSetTime') AS 'PasswordChanged' FROM sys.sql_logins
           WHERE LOGINPROPERTY([name], 'PasswordLastSetTime') < DATEADD(dd, $LookbackDays, GETDATE())
           AND NOT (LEFT([name], 2) = '##' AND RIGHT([name], 2) = '##') and is_disabled=0"
    $i++ 
    $results
}


