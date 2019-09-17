Import-Module AWSPowerShell.NetCore

$awsProfile = ""
$awsRegion  = ""
$awsSecret  = ""

Get-AWSCredentials -ProfileName awsProfile

$awsPassword = Get-SECSecretValue   -Region $awsRegion -SecretID $awsSecret -ProfileName $awsProfile | Select-Object SecretString

Write-Output $awsPassword
