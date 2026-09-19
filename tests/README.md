# ATS Test Suite

These tests demonstrate integration quality without connecting public CI to the client's production machine.

## Recommended coverage

- Python Ollama API tests against a local fixture or controlled endpoint.
- PowerShell smoke checks for Windows environments.
- Laravel HTTP-client tests using mocked responses.
- Endpoint tests for an isolated staging tunnel.
- Security tests for authentication, limits, and invalid input.

## Test rule

Production client infrastructure is never a public CI dependency.

Use local fixtures, mocks, or an explicitly controlled staging environment.
