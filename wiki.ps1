#Script to Pull Virtual Guest info and publish to wiki
#This has been automated to keep it most accurate
#This script was created by Jerry Reid
#Currently the script outputs to local html file and needs more formatting to look pretty; functionality is there"

Add-PSSnapin VMware.VimAutomation.Core 

$Header = @"
<style>
TABLE {border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}
TH {border-width: 1px;padding: 3px;border-style: solid;border-color: black;background-color: #6495ED;}
TD {border-width: 1px;padding: 3px;border-style: solid;border-color: black;}
</style>
<title>
VM Host and Guest at Location
</title>
"@
$date = Get-Date
$Pre = ""
$Post = "Updated: $date '"


#Removes the Old index.html so we start with a clear file
Remove-Item $env:USERPROFILE\Desktop\MAC.html 

#creates the new index.html file
New-Item $env:USERPROFILE\Desktop\mac.html -type file
 

 #Each loop iteration connects to the host ,pulls the info and outputs it to index.html
Connect-VIServer $HOSTNAME -Username $USERNAME -Password $PASSWORD
Get-VM | Get-NetworkAdapter | Select-Object Parent,MacAddress  | ConvertTo-HTML -Head $Header | Out-File $env:USERPROFILE\Desktop\mac.html -append


