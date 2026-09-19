<?php

declare(strict_types=1);

namespace App\Services;

use Illuminate\Support\Facades\Http;
use RuntimeException;

final class OllamaAiService
{
    public function generate(string $prompt): string
    {
        $prompt = trim($prompt);

        if ($prompt === '') {
            throw new RuntimeException('Prompt cannot be empty.');
        }

        $baseUrl = rtrim((string) config('services.ollama.base_url'), '/');
        $model = (string) config('services.ollama.model', 'qwen3.6:36b');
        $timeout = (int) config('services.ollama.timeout', 120);

        if ($baseUrl === '') {
            throw new RuntimeException('Ollama base URL is not configured.');
        }

        $response = Http::timeout($timeout)
            ->acceptJson()
            ->post($baseUrl . '/api/generate', [
                'model' => $model,
                'prompt' => $prompt,
                'stream' => false,
            ]);

        if ($response->failed()) {
            throw new RuntimeException(
                'Ollama request failed with HTTP ' . $response->status()
            );
        }

        $text = $response->json('response');

        if (!is_string($text)) {
            throw new RuntimeException('Ollama response did not contain a valid response string.');
        }

        return $text;
    }
}
