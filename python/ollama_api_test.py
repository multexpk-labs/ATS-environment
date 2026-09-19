#!/usr/bin/env python3
"""Dependency-free Ollama API health check."""

import json
import sys
import urllib.error
import urllib.request

BASE_URL = "http://127.0.0.1:11434"
MODEL_HINT = "qwen3.6"


def get_json(path: str):
    request = urllib.request.Request(f"{BASE_URL}{path}", method="GET")
    with urllib.request.urlopen(request, timeout=10) as response:
        return json.load(response)


def main() -> int:
    try:
        payload = get_json("/api/tags")
    except (urllib.error.URLError, TimeoutError) as exc:
        print(f"Ollama API unavailable: {exc}", file=sys.stderr)
        return 1

    models = payload.get("models", [])
    names = [str(item.get("name", "")) for item in models]

    print("Ollama API: OK")
    for name in names:
        print(f"  - {name}")

    if not any(MODEL_HINT.lower() in name.lower() for name in names):
        print(f"Warning: no model matching {MODEL_HINT!r} was found.", file=sys.stderr)
        return 2

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
