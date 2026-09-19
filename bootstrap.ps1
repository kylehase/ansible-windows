Write-Host "=== Configuring Windows for Ansible Management ===" -ForegroundColor Cyan

# 1. Ensure current network connection is set to Private
Write-Host "Setting active network profiles to Private..."
Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private

# 2. Install and configure OpenSSH Server
Write-Host "Installing OpenSSH Server..."
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0 -ErrorAction SilentlyContinue | Out-Null

Set-Service -Name sshd -StartupType 'Automatic'
Start-Service sshd

# 3. Restrict SSH firewall rule to Private networks only
Write-Host "Restricting SSH firewall rule to Private networks..."
Set-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -Profile Private -Enabled True

# 4. Configure default shell to PowerShell
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force | Out-Null

# 5. Set up SSH Key if provided
if ($AuthorizedKey) {
    $adminKeyPath = "$env:ProgramData\ssh\administrators_authorized_keys"
    Set-Content -Path $adminKeyPath -Value $AuthorizedKey -Force
    # Fix permissions required by OpenSSH
    icacls.exe $adminKeyPath /inheritance:r /grant "Administrators:F" /grant "SYSTEM:F" | Out-Null
    Write-Host "Configured authorized SSH key." -ForegroundColor Green
}

Write-Host "`nBootstrap Complete! You can now connect from Ansible / Semaphore." -ForegroundColor Green
Write-Host "Hostname: $(hostname)" -ForegroundColor Yellow
Write-Host "IP: $((Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias 'Wi-Fi*','Ethernet*').IPAddress -join ', ')" -ForegroundColor Yellow
