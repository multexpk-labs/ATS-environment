# Windows AI Host

The ATS host is a Windows workstation intended for local AI inference.

## Baseline

- Windows workstation
- 128 GB system RAM
- GPU acceleration hardware
- NPU hardware
- Ollama runtime
- Qwen3.6 36B model

The exact CPU/GPU/NPU model should only be published when safe. Do not publish serial numbers, asset identifiers, private addresses, or credentials.

## Baseline checks

    Get-ComputerInfo | Select-Object WindowsProductName,WindowsVersion,OsArchitecture
    Get-CimInstance Win32_ComputerSystem | Select-Object TotalPhysicalMemory
    Get-CimInstance Win32_Processor | Select-Object Name,NumberOfCores,NumberOfLogicalProcessors
    Get-CimInstance Win32_VideoController | Select-Object Name,DriverVersion

For NVIDIA:

    nvidia-smi

## NPU

NPU support depends on hardware generation, Windows support, vendor drivers, runtime/framework support, and model/operator compatibility.

Do not assume that an NPU automatically accelerates an Ollama model. Verify actual runtime behavior.

## Operational order

OS -> Driver -> Hardware -> Ollama -> Model -> API
