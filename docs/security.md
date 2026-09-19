# Security

The environment combines a Windows workstation, local inference runtime, network tunnel, public hostname, and Laravel application. Each boundary requires separate controls.

## Minimum controls

- keep Ollama private where possible;
- use authenticated application endpoints;
- validate input;
- enforce request and response limits;
- use HTTPS;
- apply rate limiting;
- keep secrets outside Git;
- log security-relevant events;
- restrict administrative access;
- patch Windows, drivers, and runtimes;
- maintain recovery procedures.

## Never commit

    .env
    tunnel tokens
    API keys
    private certificates
    private keys
    Windows credentials
    customer data
    production logs
    private IP inventories
    machine serial numbers

## AI-specific controls

Model output is untrusted data.

Do not automatically execute generated shell commands or code, and do not use model output as an authorization mechanism. Sensitive operations should remain behind deterministic application controls.
