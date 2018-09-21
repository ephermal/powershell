#Script to Pull Virtual Guest Name and Mac Address
#This has been automated to keep it most accurate
#This script was created by Jerry Reid
#Currently the script outputs to local csv file
#I had hosts that were sequentially numbered so you could use a loop

Add-PSSnapin VMware.VimAutomation.Core 

#removes old csv
Remove-Item $env:USERPROFILE\Desktop\MAC.csv

#creates the new csv
New-Item $env:USERPROFILE\Desktop\mac.csv -type file
 

Connect-VIServer$"SERVERNAME"  -Username "$USERNAME -Password "$PASSWORD"
Get-VM | Get-NetworkAdapter | Select-Object Parent,MacAddress | Export-Csv c:\scripts\mac.csv -append
