$log = C:\Users\username\Document\stdout.log

<# Before importing Credential file saved into below mentioned file using below command
$cred = Get-Credential # This will prompt for username and password
$cred | Export-Clixml -Path C:\Users\username\Document\esxi.cred #>

$cred = Import-Clixml -Path C:\Users\username\Document\esxi.cred

Connect-VIServer -Server <server_IP/server_fqdn> -Credential $cred

$vms = Get-Content -Path "C:\Users\username\Document\server.txt"

foreach($vm in $vms){
    Get-VM -Name $vms | Get-Snapshot | Remove-Snapshot -confirm:$false | Out-File $logfile -Append
    New-Snapshot -VM $vm -Name $vm-before-patch
}
