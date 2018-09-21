 function Start-SSHService {  
   [CmdletBinding()]  
  #####################################   
  ## Start and stop SSH service on connected vmhost   
  ## Created by Jerry Reid
  ## Tested on Windows 8 vpower CLI 6.0 and vsphere 5.5
  ## Next Phase is to create a menu to allow to select which one to use
  #####################################   
  Param (  
     [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, Position=0)]  
     [ValidateNotNullOrEmpty()]  
     [Alias("Name")]  
     [string]$VMHost  
   )  
   begin {}  
   Process {  
     $AllServices = Get-VMHostService -VMHost $VMHost   
     $SShService = $AllServices | Where-Object {$_.Key -eq 'TSM-SSH'}   
     if ($SShService.running -eq $false) {  
       $SShService | Start-VMHostService -confirm:$false  
     }  
     else {  
       Write-Host -BackgroundColor DarkGreen -Object "SSH service on $VMHost is already running"  
     }  
   }  
   end {}  
 }  
 
 
 function Stop-SSHService {  
   [CmdletBinding()]  
   Param (  
     [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, Position=0)]  
     [ValidateNotNullOrEmpty()]  
     [Alias("Name")]  
     [string]$VMHost  
   )  
   begin {}  
   Process {  
     $AllServices = Get-VMHostService -vmhost $VMHost   
     $SShService = $AllServices | Where-Object {$_.Key -eq 'TSM-SSH'}   
     if ($SShService.running -eq $true) {  
       $SShService | Stop-VMHostService -confirm:$false  
     }  
     else {  
       Write-Host -BackgroundColor darkGreen -Object "SSH service on $VMHost is already stopped"  
     }  
   }  
   end {}  
 }  
