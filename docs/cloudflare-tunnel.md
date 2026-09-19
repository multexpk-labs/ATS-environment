# Cloudflare Tunnel

The ATS environment uses Cloudflare Tunnel to provide an HTTPS route to the Windows AI host.

## Concept

    ats.webvpsserver.com
            |
        Cloudflare
            |
       Tunnel client
            |
      Windows service
            |
          Ollama

The tunnel avoids requiring a conventional inbound port-forwarding design on the client network.

## Important distinction

A tunnel provides network transport. It is not a replacement for application authentication.

Use authenticated application access, restrictive routing, request validation, rate limits, timeouts, structured logs, and secret management.

## Troubleshooting order

1. Verify DNS and Cloudflare configuration.
2. Verify tunnel status.
3. Verify the Windows tunnel connector.
4. Verify the local origin service.
5. Verify HTTPS response.
6. Verify application authentication.
7. Verify Ollama and model health.

Never commit tunnel tokens, sensitive config files, private certificates, or API keys.
