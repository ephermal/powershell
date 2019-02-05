#Powershell to connect to vmhost and post to db using api 
#Jerry Reid

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$Client_ID = ""
$Client_Secret = ""

Add-PSSnapin VMWare.VimAutomation.Core

$HostName_Base = ""
$Domain = ""

$vm_Username = ""
$vm_Password = ""
$webURI = ""

[System.Collections.ArrayList]$Error_Devices = @()


#Can be adjusted for nomenclature if needed
for($x=1; $x -le 114; $x++){

    $Hostname = "$HostName_Base$($x.tostring("00#"))$Domain"

    $Test = Test-Connection "$HostName_Base$($x.tostring("00#"))$Domain" -count 2

    if(!$Test){Continue}

    try{Connect-VIServer $Hostname -Username $vm_Username -Password $vm_Password -ErrorAction Stop}
        Catch{$Error_Devices.Add($Hostname) | Out-Null}
                    
                    }
            
    $VMs = Get-VM $Hostname

    foreach($VM in $VMs){

        $Object = @{
        
            vmhost = $VM.VMHost
            id = $VM.Name
            power_state = $VM.PowerState
            os = $VM.ExtensionData.Guest.guestFullName
            cpus = "$($VM.NumCpu)"
            memory = "$($VM.MemoryGB)"
            ip_address = "$($VM.guest.IPAddress[0])"
        
        }
        
        $Body = ConvertTo-Json -InputObject $Object

        $Body

        Read-Host "Post Data?"

        Invoke-RestMethod -Method Post -Uri "$webURI $Client_ID&client_secret=$Client_Secret" -Body $Body -ContentType 'application/json'
            
    }

