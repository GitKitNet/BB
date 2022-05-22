

#   WinGet.ps1
##*************************************************


# Run PS as ADMIN
# ---------------------
$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
$testadmin = $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
if ($testadmin -eq $false) {
  Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
  exit $LASTEXITCODE
}

# Set Policy 
# ------------
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned


#  WinGet Install
# -----------------
$OutLink = "$env:SYSTEMDRIVE\PS\WinGet"
$WinGetLink = "https://github.com/microsoft/winget-cli/releases/download/v1.2.10271/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
New-Item -Path $OutLink -ItemType Directory -Force
Invoke-WebRequest -Uri $WinGetLink -OutFile $OutLink\WinGet.appxbundle
Add-AppxPackage $OutLink\WinGet.appxbundle
winget --info;
winget -v


# Add Package from WinGet
# --------------------------
winget install wingetcreate -h  --accept-package-agreements --accept-source-agreements


#winget install --id Git.Git -h --accept-package-agreements --accept-source-agreements
#winget install --id Python.Python -h --accept-package-agreements --accept-source-agreements
#winget install --id GitHub.cli -h --accept-package-agreements --accept-source-agreements
#winget install --id Mozilla.Firefox -h --accept-package-agreements --accept-source-agreements
#winget install --id VideoLAN.VLC -h --accept-package-agreements --accept-source-agreements
#winget install --id CodecGuide.K-LiteCodecPack.Mega -h --accept-package-agreements --accept-source-agreements



#dotnet
System.Net.CredentialCache.DefaultCredentials
Invoke-WebRequest -UseBasicParsing 'https://dot.net/v1/dotnet-install.ps1'
&powershell -NoProfile -ExecutionPolicy unrestricted -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; &([scriptblock]::Create((Invoke-WebRequest -UseBasicParsing 'https://dot.net/v1/dotnet-install.ps1'))) -Runtime dotnet -Version 5.0.4 -InstallDir C:\cli"
&powershell -NoProfile -ExecutionPolicy unrestricted -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; &([scriptblock]::Create((Invoke-WebRequest -UseBasicParsing 'https://dot.net/v1/dotnet-install.ps1'))) -Runtime aspnetcore -Channel 5.0 -InstallDir C:\cli"
&powershell -NoProfile -ExecutionPolicy unrestricted -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; &([scriptblock]::Create((Invoke-WebRequest -UseBasicParsing 'https://dot.net/v1/dotnet-install.ps1'))) -Runtime windowsdesktop -Channel 6.0 -InstallDir C:\cli"


<#
 * Install WSL on windows
#>
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
wsl --set-default-version 2
wsl --list --online
wsl --update

$DistroName="Ubuntu-20.04"
wsl --install -d ${DistroName}
wsl -s ${DistroName}
wsl --set-default-version 2
wsl npm init
npm init



