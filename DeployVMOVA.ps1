#Script to create VM or delpoy Nessus to a vm host
#This script was created by Jerry Reid
#VMs are created using Nessus Specs
# CPU: 4
# Memory 8GB
# Hard Drive: 100GB Thin Provisioned
# SCSI Controller: LSI Logic SAS
# Network: E1000
Add-PSSnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue

#Need to update for multiple hosts
function VMCreate {
#Prompt User for Vmware Host
$VMHOST = Read-Host "Enter the FQDN of the vpshere host"
$HostUser = Read-Host "Enter the Username(root)"
$HostPass = Read-Host "Enter the Password"
Connect-VIServer $VMHOST -Username $HostUser -Password $HostPass

#Prompt User for How Many VMs they want to create 
$NumGuest = Read-Host "How many guest would you like to make "
#Create the VM with Nessus Specs

for ($i=1; $i-le$NumGuest; $i++)
{
 $Guest_hostname = Read-Host "what would you like the hostname to be [Theater]-[City]-[Role]-[#] ?"
 New-VM -Name $Guest_hostname -MemoryMB 8000 -NumCPU 4 -DiskMB 100000 -Version v8 -GuestId Server2012R2 -DiskStorageFormat thin
 Get-VM $Guest_hostname| Get-ScsiController | Set-ScsiController -Type VirtualLsiLogicSAS 
 Get-VM $Guest_hostname | Get-NetworkAdapter | Set-NetworkAdapter -Type E1000 | Set-VMQuestion -DefaultOption
#You need to start and stop the VM to generate the mac address
 Start-VM $Guest_hostname
 Start-Sleep -s 5
 Stop-VM $Guest_hostname | Set-VMQuestion -DefaultOption
}
           }


#Deploy the Nessus Image 
function DelpoyNessus{}



function DeployWindows{}



function DeployLinux{}




function ChooseYourOption{
     #Case Switch Statement or Menu
}



















