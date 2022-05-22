<#
 * Install WSL2 on windows
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













