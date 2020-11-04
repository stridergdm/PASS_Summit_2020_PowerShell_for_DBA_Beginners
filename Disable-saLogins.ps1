$demodir="$env:HOMEDRIVE$env:HOMEPATH\OneDrive\Documents\Pass Summit 2020\Scripts"


$instances = @('.,1434','.,1435','.,1436','.,1437')
$i=1
foreach ($instance in $instances)
{
    $password = "Thisis%secure$i"
    $username = "SA_$i"
    $results = invoke-sqlcmd -ServerInstance $instance -Username $username -Password $password -query "alter login sa disable"
    $i++
}
