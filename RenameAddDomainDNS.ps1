#Set Hostname, and Add to Domain
#it takes the IP and resolves it against DNS; this is required cause unattend.xml is too stupid to take hostname via DHCP
#Script by Jerry Reid


$localIpAddress=((ipconfig | findstr [0-9].\.)[0]).Split()[-1]

$localHostname= (Resolve-DnsName $localIpAddress -Server $dnsserver).namehost.split('.')[0]

Rename-Computer -NewName $localHostname -DomainCredential OBT\Administrator -Restart



