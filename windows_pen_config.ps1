# Add registry value to enable Developer Mode
# You need to run these as admin btw
$RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
if (-not(Test-Path -Path $RegistryKeyPath)) {
    New-Item -Path $RegistryKeyPath -ItemType Directory -Force
}
New-ItemProperty -Path $RegistryKeyPath -Name AllowDevelopmentWithoutDevLicense -PropertyType DWORD -Value 1

Write-Output "Setting Execution Policy to Unrestricted UwU~"
Set-ExecutionPolicy Unrestricted -Scope Process -Force;

Write-Output "Installing PSWindowsUpdate module... so exciting! O_O"
Install-Module PSWindowsUpdate -Force

Write-Output "Updating Windows... this might take a while -_-"
Install-WindowsUpdate -AcceptAll;

Write-Output "Checking if Chocolatey is already installed... fingers crossed~"
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Output "Oh noes! Chocolatey not found! Installing it for you ^_^"
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
} else {
    Write-Output "Yay! Chocolatey is already installed! *happy dance*"
}

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Write-Output "Enabling global confirmations... because who needs questions, amirite? >:]"
choco feature enable -n allowGlobalConfirmation;

Write-Output "Upgrading or installing ALL the things! Wheeee~ *spins*"
choco upgrade chocolatey python vscode git wsl2 openssh openvpn microsoft-windows-terminal netcat nmap wireshark burp-suite-free-edition heidisql sysinternals putty golang neo4j-community openjdk neovim -y;

Write-Output "Refreshing environment variables UwU... gotta keep things fresh~"

Write-Output "Adding Windows Defender exclusion O_O... plwease no suppwly chain attack >.<"
Add-MpPreference -ExclusionPath "$env:USERPROFILE\AppData\Local\Temp\chocolatey\";

Write-Output "Disabling global confirmation... it’s time to slow down a bit UwU"
choco feature disable -n allowGlobalConfirmation;
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1;
RefreshEnv;
Write-Output "Clone any other Repo's you need for hacking, but make it cute ^_^"
git clone https://github.com/dafthack/DomainPasswordSpray.git;
git clone https://github.com/PowerShellMafia/PowerSploit;

Write-Output "Nyaa~ Restarting the computer... see you on the other side >w<"
Restart-Computer -Force;
