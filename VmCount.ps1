#Count the Number of VMS using a list of hosts


$VMhosts = Get-Content c:\Users\Administrator\Desktop\esxilist.txt
$Vmcount = @()

Get-Content c:\Users\Administrator\Desktop\esxilist.txt | ForEach-Object{
    write-host $_
    Connect-ViServer $_ -Username root -Password  PASSWORD
    Get-VMHost | Select @{N="Cluster";E={Get-Cluster -VMHost $_}},Name,@{N="NumVM";E={($_ |Get-VM | where {$_.PowerState -eq "PoweredOn"}).Count}}
    $Vmcount = $Vmcount + (Get-VMHost | Select @{N="NumVM";E={($_ |Get-VM | where {$_.PowerState -eq "PoweredOn"}).Count}})
    
    }
echo $VmCount


