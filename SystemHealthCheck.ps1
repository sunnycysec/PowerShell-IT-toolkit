Write-Host "===== SYSTEM HEALTH CHECK ====="
Write-Host ""

Write-Host "Computer: $env:COMPUTERNAME"
Write-Host "User: $env:USERNAME"
Write-Host ""

$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

$freeGB = [math]::Round($disk.FreeSpace / 1GB, 2)
$totalGB = [math]::Round($disk.Size / 1GB, 2)
$usedGB = [math]::Round($totalGB - $freeGB, 2)

Write-Host "C: Drive"
Write-Host "Total Space: $totalGB GB"
Write-Host "Used Space:  $usedGB GB"
Write-Host "Free Space:  $freeGB GB"
if ($freeGB -lt 50) {
    Write-Host "Storage Status: WARNING - Less than 50 GB free"
}
else {
    Write-Host "Storage Status: OK"
}

Write-Host ""
Write-Host "===== NETWORK CHECK ====="

$internet = Test-Connection -ComputerName 8.8.8.8 -Count 2 -Quiet

if ($internet) {
    Write-Host "Internet Connectivity: PASS"
}
else {
    Write-Host "Internet Connectivity: FAIL"
}

$dns = Resolve-DnsName google.com -ErrorAction SilentlyContinue

if ($dns) {
    Write-Host "DNS Resolution: PASS"
}
else {
    Write-Host "DNS Resolution: FAIL"
}

Write-Host ""
Write-Host "===== WINDOWS SERVICES ====="

$services = @(
    "wuauserv",
    "WinDefend",
    "Spooler"
)

foreach ($serviceName in $services) {
    $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

    if ($null -eq $service) {
        Write-Host "$serviceName : NOT FOUND"
    }
    else {
        Write-Host "$($service.DisplayName) : $($service.Status) | Start Type: $($service.StartType)"
    }
}

Write-Host ""
Write-Host "===== NETWORK CONFIGURATION ====="

$network = Get-NetIPConfiguration | Where-Object {
    $_.IPv4DefaultGateway -ne $null
}

foreach ($adapter in $network) {
    Write-Host "Interface: $($adapter.InterfaceAlias)"
    Write-Host "IPv4 Address: $($adapter.IPv4Address.IPAddress)"
    Write-Host "Default Gateway: $($adapter.IPv4DefaultGateway.NextHop)"
    Write-Host "DNS Servers: $($adapter.DnsServer.ServerAddresses -join ', ')"
    Write-Host ""
}