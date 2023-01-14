# switch-ethernet (PowerShell)
# - Developer: NXU (GitHub: @jasonfoknxu)
# - https://github.com/jasonfoknxu/switch-ethernet-windows
# - Switch network with changing the Metric (Lower = Higher Priority)

### ---------- ###

$net1_name = "Ethernet" # Input the name of first network interface
$net2_name = "Ethernet 2" # Input the name of second network interface
$check_ip_url = "http://ipinfo.io/ip" # URL to check the current IP address (empty to disable checking)

### ---------- ###

$option = Read-Host "Networks:`n0 - Auto`n1 - $net1_name`n2 - $net2_name`nSwitch to"

if ($option -eq 1) {
    Write-Host "Switching to $net1_name"
    Get-NetAdapter -Name $net1_name | Set-NetIPInterface -InterfaceMetric "5"
    Get-NetAdapter -Name $net2_name | Set-NetIPInterface  -InterfaceMetric "10"
}
elseif ($option -eq 2) {
    Write-Host "Switching to $net2_name"
    Get-NetAdapter -Name $net1_name | Set-NetIPInterface -InterfaceMetric "10"
    Get-NetAdapter -Name $net2_name | Set-NetIPInterface  -InterfaceMetric "5"
}
else {
    Write-Host "Switching to Auto LAN"
    Get-NetAdapter -Name $net1_name | Set-NetIPInterface -AutomaticMetric enabled
    Get-NetAdapter -Name $net2_name | Set-NetIPInterface -AutomaticMetric enabled
}
if ($check_ip_url -ne "") {
    $currentIP = (Invoke-WebRequest -UseBasicParsing -Uri $check_ip_url).Content.Trim()
    Write-Host "Current IP: $currentIP"
}

CMD /c PAUSE