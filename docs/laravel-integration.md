# Laravel Integration

Laravel should communicate with an application-level AI service rather than coupling business logic directly to Ollama.

## Recommended abstraction

    Controller / Job
           |
       AiService
           |
     Provider adapter
           |
         Ollama
           |
      Qwen3.6 36B

This also permits a hosted provider to remain available as an optional fallback.

## Request controls

Validate prompt length, allowed model/provider, maximum output, timeout, authenticated caller, and expected content type.

## Response controls

Validate HTTP status, JSON structure, response field types, maximum response size, and timeout behavior.

Do not blindly render model output as trusted HTML or execute generated code.

## Cost strategy

Local inference can reduce hosted API consumption for suitable workloads. Measure requests/day, prompt and output size, local latency, local operating cost, hosted API cost, and quality requirements.

## Example configuration

    AI_PROVIDER=ollama
    OLLAMA_BASE_URL=http://127.0.0.1:11434
    OLLAMA_MODEL=qwen3.6:36b
    OLLAMA_TIMEOUT=120

These are examples. Use the actual deployed model tag and protected network route in the target environment.
