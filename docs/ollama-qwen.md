# Ollama + Qwen3.6 36B

Qwen3.6 36B is the primary model example for the ATS environment.

Record the exact deployed Ollama model tag and digest where available. A generic model name does not necessarily identify a single immutable artifact.

## Checks

    ollama --version
    ollama list
    ollama ps

Local API:

    Invoke-RestMethod http://127.0.0.1:11434/api/tags

## Validation

Before production integration verify:

- model is installed;
- model loads successfully;
- expected context settings;
- response format;
- latency;
- tokens/sec;
- memory consumption;
- concurrent request behavior;
- failure behavior.

Record model tag, digest, Ollama version, driver version, OS version, runtime settings, benchmark prompt, context length, and concurrency.

Never put private credentials into the repository.
