#Script to create Virtual Machines on a specific host
#This script was created by Jerry Reid
#VMs are created using the standard Build 
# CPU: 4
# Memory 16GB
# Hard Drive: 300GB Thin Provisioned
# SCSI Controller: LSI Logic SAS
# Network: E1000
Add-PSSnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue


#Prompt User for Vmware Host
$VMHOST = Read-Host "Enter the FQDN of the vpshere host"
$HostUser = Read-Host "Enter the Username(root)"
$HostPass = Read-Host "Enter the Password"
Connect-VIServer $VMHOST -Username $HostUser -Password $HostPass

#Prompt User for How Many VMs they want to create
$NumGuest = Read-Host "How many guest would you like to make "
#Create the VM with OBT 1 Specifications 

for ($i=1; $i-le$NumGuest; $i++)
{
 $Guest_hostname = Read-Host "what would you like the hostname to be (icvlab##)?"
 New-VM -Name $Guest_hostname -MemoryMB 16000 -NumCPU 4 -DiskMB 300000 -Version v8 -GuestId rhel6_64Guest -DiskStorageFormat thin
 Get-VM $Guest_hostname| Get-ScsiController | Set-ScsiController -Type VirtualLsiLogicSAS 
 Get-VM $Guest_hostname | Get-NetworkAdapter | Set-NetworkAdapter -Type E1000 | Set-VMQuestion -DefaultOption
 Start-VM $Guest_hostname
 Start-Sleep -s 5
 Stop-VM $Guest_hostname | Set-VMQuestion -DefaultOption
}

#Gets hostname and mac address into AWL format and placed on the users desktop to eliminate error
 $AWL = Get-VM | Get-NetworkAdapter | Select-Object Parent,MacAddress 
 $AWL|Export-Csv $env:USERPROFILE\Desktop\$VMHOST.txt

