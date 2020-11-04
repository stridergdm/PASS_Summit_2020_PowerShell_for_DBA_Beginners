param([parameter(mandatory)] [validateset('Dev','Prod')] $environment, [parameter(mandatory)] [validateset('2014','2016','2017','2019','Any')] $sqlversion, [parameter(mandatory)] $database, [parameter(mandatory)] $patchfile)

$demodir="$env:HOMEDRIVE$env:HOMEPATH\OneDrive\Documents\Pass Summit 2020\Scripts"
$instances_json=get-content -Raw -path (join-path -Path $demodir -ChildPath serverlist.json) | ConvertFrom-Json

$i=1
foreach ($instance in $instances_json)
{
    $password = "Thisis%secure$i"
    $username = "SA_$i"
    if ($instance.Environment -eq $environment)
        {
            if ($instance.SQLVersion -eq $sqlversion -or $sqlversion -eq 'Any')
            {
                write-host -NoNewline "This will deploy to $($instance.Server) in the $($instance.Environment) and to the following versions: "
                write-host -ForegroundColor White -BackgroundColor Red "$sqlversion"
                Invoke-Sqlcmd -ServerInstance $instance.Server -Username $username -Password $password -inputfile $patchfile -Database $database
            }
        }
    $i++
}


