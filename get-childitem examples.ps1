$demodir="$env:HOMEDRIVE$env:HOMEPATH\OneDrive\Documents\Pass Summit 2020\Scripts"
cd $demodir
import-module sqlserver

get-psdrive

set-location sqlserver:\sql\gage\Default\

get-childitem databases

$databases = get-childitem databases

$databases | where {$_.recoverymodel -eq "simple"}

$databases | where {$_.recoverymodel -eq "FULL"}

$databases | get-member

$databases | select-object -Property name, filegroups

cd databases\AdventureWorks2014\tables
$tables = get-childitem

$dbo_tables = $tables | where {$_.Schema -eq 'dbo'}


foreach ($table in $dbo_tables)
{
 
    $table | select-object -property name, rowcount
    
}


cd $demodir