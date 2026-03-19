# Innenkompass

**Lokal-first, regelbasiertes mobiles System zur situationsbasierten Selbstwahrnehmung und Selbstregulation**

Version: 1.0.0+1 · Plattform: Android (iOS vorbereitet) · Sprache: Deutsch

---

## Was ist Innenkompass?

Innenkompass ist eine mobile App, die Menschen dabei unterstützt, schwierige Situationen strukturiert zu erfassen, emotionale Reaktionen zu verstehen und gezielt zu regulieren – vollständig offline und ohne Cloud-Anbindung.

Die App führt durch eine **4-Phasen-Situations-Erfassung** (Ereignis → Emotion → Gedanke/Impuls → Reflexion), wählt automatisch passende Interventionen aus und analysiert langfristige Muster im Erleben. Ein integrierter Krisenplan ist jederzeit erreichbar.

**Kernprinzipien:**
- **Lokal-first** – alle Daten bleiben auf dem Gerät, kein Cloud-Tracking
- **Kognitiv entlastend** – geführte Schritte, keine Freitext-Flut
- **Regelbasiert** – automatische Klassifikation statt manueller Kategorisierung
- **Datenschutz by Design** – App-Sperre, sicherer Speicher, kein Telemetrie

---

## Features

- **Situations-Erfassung in 4 Phasen** – strukturierter Durchlauf: Ereignis → Emotion & Intensität → Gedanke/Impuls → Reflexion
- **9 Interventionstypen mit geführten Schritten** – `regulation`, `factCheck`, `impulsePause`, `ruminationStop`, `communication`, `overwhelmStructure`, `selfValueCheck`, `abc3`, `rsaAbcde`
- **Automatische Klassifikation** – 7 Systemzustände, 10 Emotionstypen, Krisen-Detektion
- **Post-Interventions-Evaluation** – Intensität, Spannung, Klarheit, Wirksamkeit nach der Intervention
- **Musteranalyse & Trends** – Emotionsverteilung, 7-Tage-Trend, Wochentags-Muster, Interventions-Wirksamkeit
- **Krisenplan** – editierbar: Warnsignale, Coping-Strategien, Kontakte, Ressourcen, Notfallnummern; immer zugänglich
- **App-Sperre** – Biometrie (Fingerabdruck / Face ID) mit PIN-Fallback
- **Benachrichtigungen** – optional, diskret konfigurierbar
- **Datenexport & Bereinigung** – volle Kontrolle über die eigenen Daten

---

## Tech-Stack

| Technologie | Version | Verwendungszweck |
|---|---|---|
| Flutter / Dart | SDK ≥ 3.6.1 | Cross-Platform UI |
| flutter_riverpod | 2.4.9 | State Management |
| go_router | 13.0.0 | Deklaratives Routing |
| drift | 2.14.1 | SQLite ORM |
| sqlite3 | 2.4.0 | Lokale Datenbank |
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
├── features/         # Feature-Module (11 Screens)
└── shared/           # Wiederverwendbare Widgets
```

**Schichten:**

- **`domain/`** – Kernlogik: Models, Services (`PatternAnalyzer`, `ClassificationService`, `CrisisDetector`, `InterventionSelector`)
- **`data/`** – SQLite-Persistenz via Drift: 3 Tabellen, DAOs, Repositories
- **`application/`** – Riverpod State Management: bootstrap, settings, lock, intervention flow, new-situation draft, notifications
- **`features/`** – UI-Layer: 11 Feature-Module (splash, onboarding, home, new\_situation, intervention, post\_evaluation, history, patterns, crisis, settings, lock)

---

## Datenbankschema (Schema-Version 2)

| Tabelle | Inhalt |
|---|---|
| **SituationEntries** | Kern-Log: 40+ Spalten – Ereignis, Emotion & Intensität, Körpersymptome, Gedanken/Impulse, gewählte Intervention, Post-Evaluations-Werte, Metadaten |
| **UserSettings** | App-Einstellungen: Notifications, Sprache, Lock-Typ, Theme |
| **CrisisPlan** | Persönlicher Krisenplan: Warnsignale, Coping-Strategien, Kontakte, Ressourcen |

Migrationen sind versioniert implementiert (Schema-Version 1 → 2).

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

**7 Systemzustände** (automatisch klassifiziert):
`acuteActivation` · `reflectiveReady` · `rumination` · `conflict` · `selfDevaluation` · `overwhelm` · `crisis`

**10 Emotionstypen** (7 negativ, 3 positiv) – regelbasiert aus Intensität, Körpersymptomen und Gedankeninhalten abgeleitet.

---

## Verzeichnisstruktur (Repo-Root)

```
emotion/
├── lib/                  Flutter-Quellcode
├── android/              Android Build-Konfiguration
├── test/                 Tests
├── docs/
│   ├── konzept/          Konzept- & Planungsdokumente
│   ├── legal/            Datenschutz & Support-Templates
│   └── release/          Release-Checkliste, Signing-Setup, Smoke-Tests
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

# App starten
flutter run
```

Für Android-Releases: siehe `docs/release/` für Signing-Setup und Release-Checkliste.

---

## Konzeptdokumente

Unter `docs/konzept/`:

- `03_technischer_umsetzungsplan_innenkompass.md` – technische Umsetzungsplanung
- `04_gap_analyse_konzeptv2neu.md` – Gap-Analyse zwischen Konzept und Implementierung
- `05_rechteklärung_lizenzen.md` – Lizenz- und Rechteklärung
- `07_visuelles_designkonzept_innenkompass.md` – visuelles Designkonzept
- `08_plan_fuer_auswertung_und_praktische_tipps.md` – Plan für Auswertung und praktische Tipps

---

## Lizenz

Siehe `docs/konzept/05_rechteklärung_lizenzen.md`.
