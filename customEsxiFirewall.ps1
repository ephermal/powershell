#Script to configure custom port for logging or anything vmware

Add-PSSnapin VMware.VimAutomation.Core 		


#Variables
#location of xml file
$xml_firewall=""
$esxihost =""
$credential=Get-Credential


Connect-ViServer $esxihost -Username $esxi_username -Password $esxi_password
Set-SCPFile -ComputerName $esxihost -Credential $credential -RemotePath '/etc/vmware/firewall' -LocalFile $xml_firewall

$esxcli = Get-EsxCli -VMHost $esxihost -V2


$arguments = @{
    #this ruleset ID needs to be the same as it is int he xml file
    rulesetid = ''
    }

$esxcli.network.firewall.ruleset.set.Invoke($arguments)

















