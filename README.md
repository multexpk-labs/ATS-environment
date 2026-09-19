# ATS Environment — Local AI / LLM Infrastructure

A production-oriented reference for a client AI environment built around a Windows AI workstation, 128 GB RAM, GPU/NPU acceleration, Ollama, Qwen3.6 36B, Cloudflare Tunnel, and Laravel application integration.

The goal is to run suitable AI workloads on client-controlled hardware and reduce unnecessary dependence on paid hosted-model API calls while retaining a clean application/API boundary.

Client environment note: this repository documents architecture, engineering patterns, diagnostics, and reproducible setup concepts. Private machine identifiers, tunnel credentials, API keys, customer data, and other secrets must never be committed.

## Architecture

    Internet
        |
    Cloudflare Edge
        |
    Cloudflare Tunnel
        |
    ats.webvpsserver.com
        |
    Windows AI Host
      |       |
    Ollama  GPU / NPU
      |
    Qwen3.6 36B
      |
    Ollama API
      |
    Laravel Application
      |
    AI abstraction/service layer

## Environment Profile

| Component | Role |
|---|---|
| Windows workstation | AI inference host |
| 128 GB RAM | Model/runtime capacity |
| GPU | Accelerated inference where supported |
| NPU | Specialized AI acceleration where supported |
| Ollama | Local model runtime/API |
| Qwen3.6 36B | Primary documented model example |
| Cloudflare Tunnel | HTTPS ingress without directly exposing the host |
| Laravel | Application integration layer |
| ats.webvpsserver.com | Client-facing AI endpoint |

## Laravel Integration

Keep Laravel independent from the specific model provider:

    Laravel
      |
    AI Service / Interface
      |
      +-- Ollama adapter
      +-- Hosted API adapter (optional)

This allows local inference to replace or supplement hosted inference without rewriting application business logic.

## Cloudflare Tunnel

The tunnel provides an ingress path from the public hostname to the Windows environment. A tunnel is transport, not application authentication. Use authentication, authorization, request validation, rate limiting, timeouts, and logging at the application boundary.

## Reproducible Workflow

1. Verify Windows and hardware.
2. Confirm GPU/NPU drivers and supported acceleration.
3. Install and verify Ollama.
4. Pull and validate the selected model.
5. Test inference locally.
6. Configure the application/API boundary.
7. Configure Cloudflare Tunnel.
8. Test HTTPS access.
9. Integrate Laravel.
10. Add health checks.
11. Benchmark representative workloads.
12. Document changes.

## Diagnostics

PowerShell examples:

    Get-ComputerInfo | Select-Object WindowsProductName,WindowsVersion,OsArchitecture
    Get-CimInstance Win32_ComputerSystem | Select-Object TotalPhysicalMemory
    Get-CimInstance Win32_VideoController | Select-Object Name,AdapterRAM,DriverVersion
    ollama --version
    ollama list
    ollama ps

For NVIDIA systems, where supported:

    nvidia-smi

Local Ollama API:

    Invoke-RestMethod http://127.0.0.1:11434/api/tags

Do not hard-code production endpoints, tokens, or private addresses into diagnostic scripts.

## Testing

Showcase tests should cover configuration validation, Ollama health, model availability, local inference, HTTPS endpoint reachability, tunnel routing, Laravel integration, malformed requests, timeouts, authentication, and response validation.

Public CI should use mocks or fixtures. It must not depend on the client's live machine.

## Performance

A 36B-class model's performance depends on quantization, VRAM, GPU architecture, drivers, CPU, memory bandwidth, context length, KV cache, concurrency, and prompt/output size. 128 GB system RAM does not by itself guarantee a specific tokens-per-second result. Measure representative workloads.

## Security

Never commit tunnel tokens, API keys, Laravel .env files, Windows credentials, private keys, customer data, production logs, private IP inventories, or machine serial numbers.

Model output is untrusted data. Do not execute generated commands or code automatically, and do not use model output as an authorization mechanism.

## Research Method

Observe -> Configure -> Test -> Measure -> Integrate -> Harden -> Document

For third-party technologies:

Find -> Clone -> Inspect -> Understand -> Reimplement -> Test -> Improve

Reimplementations must be original work and respect upstream licensing and attribution requirements.

## Repository Structure

    ATS-environment/
    ├── README.md
    ├── docs/
    │   ├── architecture.md
    │   ├── windows-ai-host.md
    │   ├── ollama-qwen.md
    │   ├── cloudflare-tunnel.md
    │   ├── laravel-integration.md
    │   ├── testing.md
    │   └── security.md
    ├── powershell/
    │   ├── system-report.ps1
    │   ├── gpu-report.ps1
    │   └── ollama-health.ps1
    ├── python/
    │   └── ollama_api_test.py
    ├── laravel/
    │   └── OllamaAiService.php
    ├── examples/
    │   ├── .env.example
    │   └── benchmark-request.json
    └── tests/
        └── README.md

## Related MULTEXPK LABS Work

Linux/VPS engineering, cloud infrastructure, LLM infrastructure, Ollama experiments, AI agents, coding-agent research, and PHP/Laravel engineering.

---

### MULTEXPK LABS

Technical education -> AI/LLM research -> engineering community -> practical infrastructure.

MULTEXPK LTD ®™ — Secure Cloud • VPS • Hosting • Automation

Website: https://multexpk.com  
Cloud/VPS: https://webvpsserver.com  
Support: support@multexpk.com  
WhatsApp: +92 312 6565434
