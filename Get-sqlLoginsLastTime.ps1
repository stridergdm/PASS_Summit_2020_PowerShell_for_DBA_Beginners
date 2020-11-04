$demodir="$env:HOMEDRIVE$env:HOMEPATH\OneDrive\Documents\Pass Summit 2020\Scripts"

$instances=get-content -path (join-path -Path $demodir -ChildPath instances.txt)

$i=1
foreach ($instance in $instances)
{
    $password = "Thisis%secure$i"
    $username = "SA_$i"
    $results = invoke-sqlcmd -ServerInstance $instance -Username $username -Password $password -query "select '$instance' as instance, max(login_time) as login_time, login_name from sys.dm_exec_sessions group by login_name"
      $i++ 
    $results
}


