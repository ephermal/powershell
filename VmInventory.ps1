#Script to Pull Virtual Guest info and publish to wiki
#This has been automated to keep it most accurate
#Currently the script outputs to local html file and needs more formatting to look pretty; functionality is there"

Add-PSSnapin VMware.VimAutomation.Core 
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls

$Header = @"
<style>
TABLE {border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}
TH {border-width: 1px;padding: 3px;border-style: solid;border-color: black;background-color: #6495ED;}
TD {border-width: 1px;padding: 3px;border-style: solid;border-color: black;}
</style>
<title>
VM Host and Guest at OBT 1
</title>
"@
$date = Get-Date
$Pre = ""
$Post = "Updated: $date '"


#Removes the Old index.html so we start with a clear file
Remove-Item $env:USERPROFILE\Desktop\index.html 

#creates the new index.html file
New-Item $env:USERPROFILE\Desktop\index.html -type file

#Add Date time File was Updated
$a=Get-Date
echo "Updated at" $a | Out-File $env:USERPROFILE\Desktop\index.html -append
 

#$VMhosts = .\esxilist.txt
$Vmcount = @()

$Cred1 = New-Object System.Management.Automation.PSCredential ("root",(ConvertTo-SecureString -string "$SECUREPASSWORD" -asplaintext -force))


Get-Content .\Desktop\esxilist.txt | ForEach-Object{
    write-host $_
    Connect-ViServer $_ -Credential $Cred1
    Get-VM | Select-Object -property VMHost,Name,PowerState,@{N="OS Full";E={$_.ExtensionData.Guest.guestFullName}},NumCpu,MemoryGB,@{N="IP Address";E={@($_.guest.IPAddress[0])}} | ConvertTo-HTML -Head $Header  | Out-File $env:USERPROFILE\Desktop\index.html -append
   }