cls
get-service | Where-object {$_.name -like '*sql*'}
read-host "Press enter"

get-help
read-host "Press enter"
get-help get-service
read-host "Press enter"
get-service -ComputerName gage | Where-object {$_.name -like '*sql*'}
read-host "Press enter"
get-help get-service -ShowWindow


get-service | get-member
