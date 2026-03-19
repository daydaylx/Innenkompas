# Innenkompass

**Lokal-first, regelbasierte Android-App zur situationsbasierten Selbstwahrnehmung und Selbstregulation**

> **Hinweis:** Dieses Projekt ist für die **private Nutzung** gedacht. Die App wird nicht über einen offiziellen Store vertrieben, sondern als APK direkt installiert (Sideloading).

Version: 1.0.0+1 · Plattform: Android · Sprache: Deutsch

---

## Was ist Innenkompass?

Innenkompass ist eine mobile App für den privaten Gebrauch, die Menschen dabei unterstützt, schwierige Situationen strukturiert zu erfassen, emotionale Reaktionen zu verstehen und gezielt zu regulieren. Die Datenverarbeitung ist lokal-first; eine freie KI-Auswertung ist nur in speziell konfigurierten Privat-Builds optional zuschaltbar.

Die App führt durch eine **4-Phasen-Situations-Erfassung** (Ereignis → Emotion → Gedanke/Impuls → Reflexion), wählt automatisch passende Interventionen aus und analysiert langfristige Muster im Erleben. Ein integrierter Krisenplan ist jederzeit erreichbar.

**Kernprinzipien:**
- **Lokal-first** – Daten bleiben standardmäßig auf dem Gerät, keine Cloud-Synchronisierung, kein Tracking
- **Kognitiv entlastend** – geführte Schritte, keine Freitext-Flut
- **Regelbasiert** – automatische Klassifikation statt manueller Kategorisierung
- **Datenschutz by Design** – App-Sperre, sicherer Speicher, kein Telemetrie
- **Optionale KI-Auswertung** – nur wenn ein privater Build explizit mit Worker-Endpoint konfiguriert wurde
- **Privates Projekt** – kein Store, kein Tracking, kein kommerzieller Vertrieb

---

## Features

- **Situations-Erfassung in 4 Phasen** – strukturierter Durchlauf: Ereignis → Emotion & Intensität → Gedanke/Impuls → Reflexion
- **9 Interventionstypen mit geführten Schritten** – `regulation`, `factCheck`, `impulsePause`, `ruminationStop`, `communication`, `overwhelmStructure`, `selfValueCheck`, `abc3`, `rsaAbcde`
- **Automatische Klassifikation** – 8 Systemzustände, 10 Emotionstypen, Krisen-Detektion
- **Post-Interventions-Evaluation** – Intensität, Spannung, Klarheit, Wirksamkeit nach der Intervention
- **Optionale KI-Auswertung** – kurze zusätzliche Einordnung über einen privaten Cloudflare-Worker/OpenRouter-Pfad, nur bei expliziter Konfiguration und Anforderung
- **Musteranalyse & Trends** – Emotionsverteilung, 7-Tage-Trend, Wochentags-Muster, Interventions-Wirksamkeit
- **Krisenplan** – editierbar: Warnsignale, Coping-Strategien, Kontakte, Ressourcen, Notfallnummern; immer zugänglich
- **App-Sperre** – Biometrie (Fingerabdruck / Face ID) mit PIN-Fallback
- **Benachrichtigungen** – optional, diskret konfigurierbar
- **Datenexport & Bereinigung** – volle Kontrolle über die eigenen Daten

---

## Tech-Stack

| Technologie | Version | Verwendungszweck |
|---|---|---|
| Flutter / Dart | SDK ≥ 3.6.1 | Android-App |
| flutter_riverpod | 2.4.9 | State Management |
| go_router | 13.0.0 | Deklaratives Routing |
| drift | 2.14.1 | SQLite ORM |
| sqlite3 | 2.4.0 | Lokale Datenbank |
| http | 1.2.2 | Optionaler HTTP-Client für KI-Auswertung |
| freezed | 2.4.6 | Immutable Models (Code-Gen) |
| local_auth | 2.1.6 | Biometrie-Authentifizierung |
| flutter_secure_storage | 9.0.0 | Sicherer Schlüsselspeicher |
| flutter_local_notifications | 19.5.0 | Lokale Benachrichtigungen |
| fl_chart | 0.65.0 | Diagramme & Visualisierungen |

---

## Architektur

Domain-Driven Layered Architecture:

```
lib/
├── app/              # MaterialApp, Theme, Router
├── application/      # Riverpod Providers & State Notifiers
├── core/             # Konstanten, Enums, Validatoren
├── data/             # Drift DB, DAOs, Repositories
├── domain/           # Business-Modelle, Services, Rule-Engines
├── features/         # Feature-Module
└── shared/           # Wiederverwendbare Widgets
```

Optionaler Zusatzpfad für private Builds:

```text
Flutter App -> OpenRouterAiEvaluationService -> Cloudflare Worker -> OpenRouter
```

**Schichten:**

- **`domain/`** – Kernlogik: Models, Services (`PatternAnalyzer`, `ClassificationService`, `CrisisDetector`, `InterventionSelector`)
- **`data/`** – SQLite-Persistenz via Drift: Tabellen, DAOs, Repositories
- **`application/`** – Riverpod State Management: bootstrap, settings, lock, intervention flow, new-situation draft, notifications
- **`features/`** – UI-Layer: Feature-Module für Erfassung, Intervention, Verlauf, Muster, Krise, Einstellungen und optionale KI-Auswertung

---

## Datenbankschema (Schema-Version 4)

| Tabelle | Inhalt |
|---|---|
| **SituationEntries** | Kern-Log: Ereignis, Emotion & Intensität, Körpersymptome, Gedanken/Impulse, gewählte Intervention, Post-Evaluations-Werte, Metadaten und optionale KI-Auswertungsfelder |
| **UserSettings** | App-Einstellungen: Notifications, Sprache, Lock-Typ, Theme |
| **CrisisPlan** | Persönlicher Krisenplan: Warnsignale, Coping-Strategien, Kontakte, Ressourcen |

Migrationen sind versioniert implementiert (Schema-Version 1 → 4).

---

## Routing

| Route | Pfad | Funktion |
|---|---|---|
| Onboarding | `/onboarding` | Ersteinrichtung |
| Home | `/` | Dashboard & Einstieg |
| Ereignis | `/new-situation/event` | Phase 1 der Erfassung |
| Emotion | `/new-situation/emotion` | Phase 2 |
| Gedanke/Impuls | `/new-situation/thought-impulse` | Phase 3 |
| Reflexion | `/new-situation/reflection` | Phase 4 |
| Intervention | `/intervention` | Geführte Intervention |
| Post-Evaluation | `/post-evaluation` | Bewertung nach Intervention |
| Verlauf | `/history` | Alle erfassten Situationen |
| Detail | `/history/:id` | Einzelne Situation |
| Muster | `/patterns` | Analyse & Trends |
| Krisenplan | `/crisis` | Krisenplan-Ansicht |
| Krisenplan bearbeiten | `/crisis/edit` | Krisenplan-Editor |
| Einstellungen | `/settings` | App-Konfiguration |
| Sperre | `/lock` | Biometrie / PIN |

**Guard-Logik:** Onboarding-Check beim Start, Lock-Redirect bei gesperrter App, Krisenplan immer direkt erreichbar.

---

## Systemzustände & Emotionstypen

**8 Systemzustände** (automatisch klassifiziert):
`acuteActivation` · `reflectiveReady` · `interpretation` · `rumination` · `conflict` · `selfDevaluation` · `overwhelm` · `crisis`

**10 Emotionstypen** (7 negativ, 3 positiv) – regelbasiert aus Intensität, Körpersymptomen und Gedankeninhalten abgeleitet.

---

## Verzeichnisstruktur (Repo-Root)

```
emotion/
├── lib/                  Flutter-Quellcode
├── android/              Android Build-Konfiguration (Hauptzielplattform)
├── test/                 Tests
├── docs/
│   ├── konzept/          Konzept- & Planungsdokumente
│   ├── legal/            Datenschutzhinweise & Support-Infos (private Nutzung)
│   └── release/          APK-Build-Anleitung, Signing-Setup (optional)
├── workers/              Optionaler Cloudflare-Worker für freie KI-Auswertung
├── pubspec.yaml
└── README.md
```

> `innenkompass/` (lokale Referenzkopie mit eigenem Git-History) ist via `.gitignore` ausgeschlossen.

---

## Setup & Entwicklung

```bash
# Abhängigkeiten installieren
flutter pub get

# Code-Generierung (Drift, Freezed, Riverpod)
dart run build_runner build --delete-conflicting-outputs

# App starten (während der Entwicklung)
flutter run

# Debug-APK für private Installation bauen
flutter build apk --debug
# Die APK liegt unter: build/app/outputs/flutter-apk/app-debug.apk
```

Die APK kann direkt per USB auf ein Android-Gerät installiert werden (Sideloading):

```bash
adb install -r build/app/outputs/flutter-apk/app-debug.apk
```

Für optionales Release-Signing (nur bei Verteilung außerhalb des eigenen Geräts): siehe `docs/release/signing-setup.md`.

Optionale KI-Auswertung für private Builds:

```bash
flutter run \
  --dart-define=AI_EVALUATION_BASE_URL=https://<dein-worker-host> \
  --dart-define=AI_EVALUATION_APP_TOKEN=<shared-token>
```

Details zur optionalen Worker-Konfiguration: `workers/ai-evaluation/README.md`

---

## Konzeptdokumente

Unter `docs/konzept/`:

- `03_technischer_umsetzungsplan_innenkompass.md` – technische Umsetzungsplanung
- `04_gap_analyse_konzeptv2neu.md` – Gap-Analyse zwischen Konzept und Implementierung
- `05_rechteklärung_lizenzen.md` – Lizenz- und Rechteklärung (mit Fokus auf private Nutzung)
- `07_visuelles_designkonzept_innenkompass.md` – visuelles Designkonzept
- `08_plan_fuer_auswertung_und_praktische_tipps.md` – Plan für Auswertung und praktische Tipps

---

## Lizenz & Rechtliches

Dieses Projekt ist für die **private Nutzung** konzipiert. Für die reine Eigennutzung gelten reduzierte Anforderungen im Vergleich zu einer öffentlichen oder breiteren externen Verbreitung.

- **Datenschutzhinweis:** `docs/legal/privacy-policy-template.md`
- **Support-Information:** `docs/legal/support-template.md`
- **Lizenzklärung:** `docs/konzept/05_rechteklärung_lizenzen.md`
- **Optionale KI-Auswertung:** `workers/ai-evaluation/README.md`

> **Wichtig:** Bei privater Weitergabe an einzelne Dritte sollten die rechtlichen Hinweise geprüft und für den konkreten Build angepasst werden. Das gilt besonders, wenn die optionale KI-Auswertung aktiviert ist.
