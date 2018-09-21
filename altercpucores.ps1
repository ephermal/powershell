#------------------------------------------------------------------------
# Created by Jerry Reid
# Script created to change cpu cores on demand without the use of vsphere
#------------------------------------------------------------------------
Add-PSSnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue

#Prompt User for Vmware Host
$VMHOST = Read-Host "Enter the FQDN of the vpshere host"
$HostUser = Read-Host "Enter the Username(root)"
$HostPass = Read-Host "Enter the Password"

#Connect to the Host
Connect-VIServer $VMHOST -Username $HostUser -Password $HostPass

#Prompt User for guest name and how many cores
$vmname = Read-Host "Enter the vmname would like to change"
$cores  = Read-Host "How many Cores would you like to set the VM to"

#Stop the VM
Stop-VM $vmname
#Set the number of cores
$setcores = new-object -typename VMware.VIM.virtualmachineconfigspec -property @{'numcorespersocket'=1;'numCPUs'=$cores}
#Alter the VM
(Get-VM $vmname).ExtensionData.ReconfigVM_Task($setcores)
#Start the VM again
Start-VM $vmname

