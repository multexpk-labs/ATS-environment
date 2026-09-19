$ErrorActionPreference = "Stop"

$base = "http://127.0.0.1:11434"
Write-Host "Checking Ollama: $base"

try {
    $tags = Invoke-RestMethod -Uri "$base/api/tags" -Method Get -TimeoutSec 10
    Write-Host "Ollama API: OK"
    Write-Host "Models:"
    $tags.models | Select-Object name, size, digest | Format-Table
} catch {
    Write-Error "Ollama API check failed: $($_.Exception.Message)"
    exit 1
}
