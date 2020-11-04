$demodir="$env:HOMEDRIVE$env:HOMEPATH\OneDrive\Documents\Pass Summit 2020\Scripts"


$instances_txt=get-content -path (join-path -Path $demodir -ChildPath instances.txt)

$instances_json_raw=get-content -Raw -path (join-path -Path $demodir -ChildPath serverlist.json) 

$instances_json=get-content -Raw -path (join-path -Path $demodir -ChildPath serverlist.json) | ConvertFrom-Json

write-host "This is the text file"
$instances_txt
read-host "Press enter"
Write-Host "---------------------------------------------"
Write-Host "This is the raw JSON file"
$instances_json_raw
read-host "Press enter"

Write-Host "---------------------------------------------"
Write-Host "This is the converted JSON file"
$instances_json

