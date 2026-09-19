# Testing Strategy

The public repository should demonstrate that the integration is engineered and testable without requiring access to the client's live machine.

## Test layers

### Configuration

Validate required variables and reject missing or unsafe values.

### Ollama API

Test endpoint reachability, model listing, expected model presence, valid requests, malformed requests, and timeout handling.

### Tunnel endpoint

Test DNS resolution, HTTPS, expected status, authentication, and response timeout in an isolated staging environment.

Never run public CI against the client's production endpoint.

### Laravel

Use mocked HTTP responses for successful inference, upstream 4xx/5xx responses, timeouts, malformed JSON, and oversized responses.

## Showcase commands

    .powershellsystem-report.ps1
    .powershellgpu-report.ps1
    .powershellollama-health.ps1

    python .pythonollama_api_test.py

## CI principle

CI should be deterministic and offline-friendly. Hardware-dependent tests belong in controlled environments, not public CI.
