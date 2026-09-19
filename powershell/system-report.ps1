$ErrorActionPreference = "SilentlyContinue"

Write-Host "=== ATS Windows System Report ==="
Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, OsArchitecture

$computer = Get-CimInstance Win32_ComputerSystem
Write-Host ""
Write-Host "RAM:"
"{0:N2} GB" -f ($computer.TotalPhysicalMemory / 1GB)

Write-Host ""
Write-Host "CPU:"
Get-CimInstance Win32_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors

Write-Host ""
Write-Host "GPU:"
Get-CimInstance Win32_VideoController | Select-Object Name, DriverVersion

Write-Host ""
Write-Host "Ollama:"
if (Get-Command ollama -ErrorAction SilentlyContinue) {
    ollama --version
} else {
    Write-Host "ollama: not found"
}
