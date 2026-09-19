$ErrorActionPreference = "SilentlyContinue"

Write-Host "=== GPU / Accelerator Report ==="

Get-CimInstance Win32_VideoController |
    Select-Object Name, AdapterRAM, DriverVersion, VideoModeDescription

Write-Host ""
Write-Host "NVIDIA:"
if (Get-Command nvidia-smi -ErrorAction SilentlyContinue) {
    nvidia-smi --query-gpu=name,driver_version,memory.total,utilization.gpu --format=csv,noheader
} else {
    Write-Host "nvidia-smi not available; this is not proof that no accelerator exists."
}

Write-Host ""
Write-Host "NPU availability requires vendor/runtime-specific tooling."
