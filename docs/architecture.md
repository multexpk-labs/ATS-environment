# ATS Architecture

## Reference topology

    Browser / Laravel application
              |
            HTTPS
              |
        Cloudflare Edge
              |
       Cloudflare Tunnel
              |
        Windows AI host
              |
           Ollama
              |
         Qwen3.6 36B

## Application boundary

Prefer:

    Laravel -> authenticated AI endpoint -> Ollama

rather than exposing Ollama as an unrestricted public service.

The application boundary should handle authentication, request validation, timeouts, rate limiting, logging, and response validation.

## Failure boundaries

Treat these as separate components:

1. DNS and Cloudflare configuration
2. Tunnel connectivity
3. Windows host availability
4. Ollama process
5. Model availability
6. Inference execution
7. Laravel integration

Change one layer at a time and verify it before moving to the next layer.
