# AI Evaluation Worker

Minimaler Edge-Worker für die freie KI-Auswertung von Innenkompass.

> Hinweis: Dieser Worker ist ein optionaler Zusatzpfad für private Builds. Innenkompass bleibt ohne Worker lokal nutzbar; eine öffentliche Distribution ist nicht vorgesehen.

## Zweck

- nimmt normalisierte Eintragsdaten von der App entgegen
- blockiert Kriseneinträge vor dem Modellaufruf
- ruft OpenRouter mit `openai/gpt-4.1-mini` auf
- erzwingt ein kleines JSON-Schema
- gibt nur validierte UI-Daten an die App zurück

## Erwarteter Endpoint

Die Flutter-App erwartet standardmäßig:

```text
POST <AI_EVALUATION_BASE_URL>/ai-evaluations
```

Wenn du den Worker direkt unter dieser Route deployest, genügt in der App:

```bash
--dart-define=AI_EVALUATION_BASE_URL=https://<dein-worker-host>
```

Optional kann zusätzlich ein App-Token gesetzt werden:

```bash
--dart-define=AI_EVALUATION_APP_TOKEN=<shared-token>
```

## Benötigte Worker-Secrets / Vars

- `OPENROUTER_API_KEY`
- optional `OPENROUTER_MODEL`
- optional `OPENROUTER_HTTP_REFERER`
- optional `OPENROUTER_APP_TITLE`
- optional `APP_API_TOKEN`
- optional `OPENROUTER_TIMEOUT_MS` (Default: `15000`)
- optional `OPENROUTER_TEMPERATURE` (Default: `0.15`)
- optional `OPENROUTER_MAX_OUTPUT_TOKENS` (Default: `220`)
- optional `CORS_ALLOWED_ORIGINS` (kommagetrennte Origin-Allowlist)
- optional `RATE_LIMIT_MAX_REQUESTS` (Default: `10`)
- optional `RATE_LIMIT_WINDOW_SECONDS` (Default: `600`)

## Cloudflare Wrangler Beispiel

```toml
name = "innenkompass-ai-evaluation"
main = "worker.js"
compatibility_date = "2026-03-19"
```

Secrets:

```bash
wrangler secret put OPENROUTER_API_KEY
wrangler secret put APP_API_TOKEN
```

Optional:

```bash
wrangler secret put OPENROUTER_HTTP_REFERER
wrangler secret put OPENROUTER_APP_TITLE
```

Vars:

```bash
wrangler secret put APP_API_TOKEN
wrangler deploy --var CORS_ALLOWED_ORIGINS=https://app.example.com
wrangler deploy --var RATE_LIMIT_MAX_REQUESTS=10
wrangler deploy --var RATE_LIMIT_WINDOW_SECONDS=600
wrangler deploy --var OPENROUTER_TIMEOUT_MS=15000
wrangler deploy --var OPENROUTER_TEMPERATURE=0.15
wrangler deploy --var OPENROUTER_MAX_OUTPUT_TOKENS=220
```

Deploy:

```bash
wrangler deploy
```

## Antwortformat

```json
{
  "provider": "openrouter",
  "model": "openai/gpt-4.1-mini",
  "schema_version": 1,
  "completed_at": "2026-03-19T10:15:00.000Z",
  "evaluation": {
    "was_auffaellt": "…",
    "einordnung": "…",
    "praktisch_hilfreich": "…",
    "vorsichtshinweis": "…"
  }
}
```

## Sicherheits- und Betriebsverhalten

- Der Worker akzeptiert `POST` auf `/ai-evaluations` auch unter Subpfaden, z. B. `/v1/ai-evaluations`.
- Ohne `CORS_ALLOWED_ORIGINS` wird kein browserfreundlicher `Access-Control-Allow-Origin` gesetzt.
- Das Rate-Limit ist bewusst ein leichtgewichtiges Best-Effort-Limit im Worker. Es reduziert Missbrauch deutlich, ersetzt aber keine verteilte Cloudflare-WAF-/Rate-Limit-Regel.
- Upstream-Timeouts gegen OpenRouter enden kontrolliert mit `504`, statt unbegrenzt zu hängen.
- Vor dem Modellaufruf werden interne App-Codes in lesbare deutsche Hinweise umgewandelt, damit das Modell nicht auf Enum-/Key-Namen raten muss.
- Der System-Prompt trennt jetzt klar zwischen Beobachtung, Einordnung und einem kleinen nächsten Schritt. Freitexte aus dem Eintrag werden explizit als Daten und nicht als Instruktionen behandelt.
- Für private Nutzung sollte der Worker nur dann deployt werden, wenn die KI-Auswertung im konkreten Build wirklich gewünscht ist.
