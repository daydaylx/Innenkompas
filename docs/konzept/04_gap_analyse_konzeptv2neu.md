---
title: "Gap-Analyse: konzeptv2neu.md vs. aktuelle Implementierung"
document_type: "gap-analysis"
project: "Innenkompass"
version: "1.0"
status: "aktiv"
date_created: "2026-03-16"
last_updated: "2026-03-16"
language: "de"
source_document: "konzeptv2neu.md"
audience:
  - "Entwicklung"
  - "Produktplanung"
  - "Architektur"
purpose: "Systematischer Abgleich zwischen dem Konzeptdokument konzeptv2neu.md und dem aktuellen Implementierungsstand. Basis für priorisierte Aktionsplanung."
---

# Gap-Analyse: konzeptv2neu.md vs. aktuelle Implementierung

## Kontext

`konzeptv2neu.md` ist ein neueres Konzeptdokument, das die ursprünglichen Konzepte (01–03) um folgende Bereiche erweitert:
- Rechtliche und lizenzrechtliche Analyse (IBT/Kohlhammer, UP/Hogrefe, ODSIS/OUP)
- Template-Engine-Architektur statt fixer Interventions-Typen
- Konkrete Feldspezifikationen für ABC-3, RSA/ABCDE und Belastungsskala
- Produktpositionierung und regulatorische Abgrenzung (DiGA, DSGVO Art. 9)

---

## Abschnitt 1: Vollständig aligned — kein Handlungsbedarf

Die folgenden Bereiche sind zwischen Konzept und Implementierung vollständig übereinstimmend.

| Bereich | konzeptv2neu.md-Anforderung | Implementierung | Ort |
|---|---|---|---|
| Local-first Architektur | Pflicht | ✓ Drift/SQLite, kein Cloud | `app_database.dart` |
| App-Lock / Biometric | Optional, muss vorhanden sein | ✓ | `lock_service.dart` |
| Krisenmodul | Always accessible | ✓ | `crisis_screen`, `crisis_plan` |
| Draft Auto-Save | Nach jedem Step | ✓ | `situation_draft.dart` |
| Ruhige UX / Calm Design | Chips, große Cards | ✓ | `AppTheme`, shared widgets |
| Emotions-Typen | 10 Basisemotionen | ✓ | `emotion_types.dart` |
| Körpersymptom-Liste | Körpersignale | ✓ 15 Symptome | `app_constants.dart` |
| Vor-/Nachbewertung | Δ-Rating | ✓ | `post_evaluation_screen` |
| DSGVO Art. 9 | Gesundheitsdaten lokal | ✓ keine Cloud-Sync im MVP | gesamte Architektur |
| Crisis-Hotlines | In App sichtbar | ✓ | `app_constants.dart` |
| Historien-/Musteransicht | Pattern recognition | ✓ | history + patterns features |
| WCAG 48dp Touch Targets | Accessibility | ✓ `buttonHeight=56dp` | `AppTheme` |

---

## Abschnitt 2: Teilweise umgesetzt — Anpassungsbedarf

### 2.1 State-Klassifikation: 8 Zustände vs. 4 Zustände

**konzeptv2neu.md-Position:**
Vereinfacht auf 4 Zustände als „Heuristik-Beispiel":
- `acute_activation`
- `reflective_ready`
- `rumination`
- `crisis`

**Aktuelle Implementierung:**
8 Zustände:
- `acuteActivation`, `reflectiveReady`, `rumination`, `crisis` (aus Konzept)
- zusätzlich: `interpretation`, `conflict`, `selfDevaluation`, `overwhelm`

**Datei:** `state_classifier.dart`, `system_states.dart`

**Bewertung:** Die 8-Zustands-Logik ist detaillierter und klinisch sinnvoller. Das Konzeptdokument nennt 4 Zustände explizit als vereinfachtes Heuristik-Beispiel — kein Widerspruch zur Vollimplementierung.

**Empfehlung:** 8-State-Logik beibehalten. Dokumentation um Erklärung ergänzen, warum die Vollversion 8 Zustände nutzt.

**Aktion:** In `state_classifier.dart` dokumentiert. Status: erledigt.

---

### 2.2 Interventions-Modell → Template-Engine

**konzeptv2neu.md-Anforderung:**
Eine `WorksheetTemplate`-Entität mit:
- `id`, `type`, `steps[]`, `field_defs[]`, `version`, `license_tag`
- JSON-Payload-basierte `WorksheetEntry`-Speicherung
- Template-Registry-Konzept für spätere Erweiterbarkeit

**Aktuelle Implementierung:**
- `Intervention` + `InterventionStep` (typisiert, Dart-Klassen mit Freezed)
- `InterventionLibrary` als statische Sammlung
- `licenseTag` + `licenseNotes` direkt auf `Intervention`
- Keine JSON-Payload-Flexibilität

**Gap:**
- Keine formale `TemplateDefinition`-Abstraktion
- Fehlende JSON-Payload-Schicht für `SituationEntry`

**Konsequenz:** Zukünftige neue Templates würden neue DB-Migrationen erfordern, wenn Felder strikt typisiert bleiben.

**Aktion (Prio 2):** Leichtgewichtige Rechte-Metadaten sind umgesetzt. Template-Registry-Konzept bleibt ein separater Zukunftsschritt.

---

### 2.3 Eintrag-Payload: rigid types → JSON

**konzeptv2neu.md-Vorschlag:**
```json
"entry": {
  "payload": {
    "a": { "description": "…" },
    "b": { "thoughts": [ "…" ] },
    "c": { "emotion": { "primary": "Ärger", "intensity": 8 } }
  }
}
```

**Aktuelle Implementierung:**
`SituationDraft` hat typisierte Dart-Felder (Freezed-Klassen). `SituationEntries`-Tabelle hat explizite Spalten pro Feld.

**Trade-off:**

| Aspekt | Typisierte Felder (aktuell) | JSON-Blob |
|---|---|---|
| Query-Einfachheit | ✓ einfach | schwerer (JSON-Parsing) |
| Migrations-Aufwand bei neuen Templates | hoch (neue Spalten) | gering (JSON-Feld) |
| Type-Safety | ✓ vollständig | nur zur Laufzeit |
| Template-Flexibilität | gering | ✓ hoch |

**Empfehlung:** Für MVP typisierte Felder beibehalten (ABC-3 + RSA passen in bestehende Struktur). Hybrid-Strategie: `payload_json`-Spalte als optionales Extension-Feld hinzufügen.

**Aktion (Prio 2):** Entscheidung dokumentieren und `payload_json` als nullable Spalte in `situation_entries.dart` einplanen.

---

## Abschnitt 3: Neue Features / Statusabgleich

### 3.1 ABC-3 Kurzprotokoll-Template

**Status:** Leichtgewichtig implementiert als `Intervention`-Template

**Anforderung (konzeptv2neu.md):**
- `situation.description` (Text, Pflicht)
- `beliefs[]` (Array, min. 1)
- `consequence.emotions[]` (Emotion + Intensität)
- `consequence.body_signals[]` (Multi-Select)
- `consequence.behavior` (Enum + Text)
- Nachbewertung (Intensität + Klarheit 0–10)

**Aktion (Prio 3):** Bestehende `abc3Protocol`-Implementierung dokumentieren. Separate Template-Registry nur bei späterem Ausbau einführen.

**Implementierungshinweis:** Verwendet vorhandene `InterventionStepType`-Werte (`reflection`, `selection`, `rating`). Neuer `InterventionType.abc3` erforderlich.

---

### 3.2 RSA/ABCDE-Template (mehrstufig)

**Status:** Leichtgewichtig implementiert

**Anforderung (konzeptv2neu.md):**
- D1 „Wahr?": `rsa.d.truth_check` (Enum + Begründung)
- D2 „Hilfreich?": `rsa.d.usefulness_check` (Enum + Begründung)
- Perspektivwechsel: `rsa.d.perspective_prompts[]`
- E1: `rsa.e.rational_alternative` (Text, Pflicht)
- E2: `rsa.e.desired_emotion` (Enum)
- E3: `rsa.e.desired_behavior` (Text)
- Re-Rating: Intensität vorher/nachher

**Flow:** Mehrstufiger Disputation-Screen: 1 Gedanke → D1 → D2 → Perspektive → E → Re-Rating

**Aktion (Prio 3):** Bestehende `rsaAbcde`-Implementierung beibehalten. Separate Template-Registry nur bei späterem Ausbau einführen.

---

### 3.3 Belastungsskala — eigenentwickelte Kurzskala

**Status:** Implementiert

**Hintergrund:**
Die ODSIS-Skala (Overall Depression Severity and Impairment Scale) ist urheberrechtlich geschützt (Oxford University Press). Für das MVP muss eine eigenentwickelte Kurzskala in eigenen Worten erstellt werden.

**Anforderung (konzeptv2neu.md — adaptiert):**
- 5 Items, je 0–4
- Bereiche: Häufigkeit, Intensität, Freude/Aktivitäten, Aufgaben/Rolle, Soziales
- Summe 0–20
- Wiederholbar (Verlaufsbeobachtung)
- Kein Diagnose-Label — nur Summenwert + Verlauf

**Aktion (Prio 3):** Bestehende `SelbsteinschätzungsSkala` beibehalten und die Rechte-Metadaten weiter dokumentieren.

---

### 3.4 License-Tag-System

**Status:** Leichtgewichtig implementiert

**Anforderung (konzeptv2neu.md):**
Jedes Template braucht einen `license_tag`, z.B.:
- `"original-inspired-no-copy"` — Eigenentwicklung, inhaltlich ähnlich
- `"license-required"` — nur mit Verlagsgenehmigung freischaltbar
- `"licensed-kohlhammer"` — nach Rechteklärung mit Kohlhammer
- `"public-domain"` — frei verwendbar

**Zweck:** Template-Registry kann später zwischen MVP-Templates (eigenentwickelt) und lizenzierten Templates unterscheiden.

**Aktion (Prio 2):** `licenseTag`/`licenseNotes` im bestehenden `Intervention`-Modell beibehalten. Separate Template-Registry nur bei künftigem Ausbau einführen.

---

### 3.5 Atemtimer als optionaler Pre-Step

**Status:** Teilweise vorhanden

**Anforderung (konzeptv2neu.md):**
60–90s optionaler Atemtimer vor Bewertungs-/Erfassungsstart

**Aktuell:**
Das Breathing-Widget existiert als Intervention (`regulation4_6Breathing`), aber nicht als optionalen Pre-Step vor dem Situations-Flow.

**Aktion (Prio 3, niedrig):** Optional einen „Kurz durchatmen?" Pre-Screen als erste Frage im Situations-Flow einbauen. Kein eigener Screen nötig — reicht als einzelner Step.

---

## Abschnitt 4: Offene Kritische Fragen

### Frage 1: State-Klassifikation
**Frage:** 7 Zustände beibehalten oder auf 4 vereinfachen?
**Empfehlung:** Beibehalten. 7 Zustände ermöglichen präzisere Interventionsauswahl. Konzept nennt 4 als Minimalbeispiel.
**Status:** Entschieden — 7 Zustände.

---

### Frage 2: Payload-Strategie
**Frage:** JSON-Blob in DB (flexibel, schwererer Query) oder typisierte Felder (starr, einfacher)?
**Empfehlung:** Hybrid — bestehende typisierte Felder für MVP, `payload_json` als nullable Extension für neue Templates.
**Status:** Offen — Architekturentscheidung vor Feature-3-Implementierung notwendig.

---

### Frage 3: Template-Engine-Timing
**Frage:** Jetzt refactoren oder erst nach ABC-3/RSA Screens?
**Empfehlung:** Jetzt Konzept finalisieren, Code-Refactor erst nach stabiler MVP-Basis.
**Status:** Offen.

---

## Abschnitt 5: Priorisierter Aktionsplan

### Prio 1 — Dokumentation (erledigt mit diesem Dokument)

| # | Aufgabe | Datei | Status |
|---|---|---|---|
| 1.1 | Gap-Analyse-Dokument erstellen | `04_gap_analyse_konzeptv2neu.md` | ✓ erledigt |
| 1.2 | Rechteklärung-Matrix erstellen | `05_rechteklärung_lizenzen.md` | ✓ erledigt |

---

### Prio 2 — Architektur (vor neuem Feature-Code)

| # | Aufgabe | Datei | Status |
|---|---|---|---|
| 2.1 | Template-Registry-Konzept in technischem Plan ergänzen | `03_technischer_umsetzungsplan_innenkompass.md`, Abschnitt 21 | ✓ erledigt |
| 2.2 | JSON-Payload-Strategie definieren (Hybrid-Ansatz) | `03_technischer_umsetzungsplan_innenkompass.md`, Abschnitt 21 | ✓ erledigt |
| 2.3 | `license_tag`-Konzept dokumentieren | `05_rechteklärung_lizenzen.md` | ✓ erledigt |

---

### Prio 3 — Neue Features (nach Architektur-Klärung)

| # | Aufgabe | Datei | Status |
|---|---|---|---|
| 3.1 | `InterventionType.abc3` + `rsaAbcde` zu Enum hinzufügen | `intervention_types.dart` | ✓ erledigt |
| 3.2 | ABC-3 Template als Intervention implementieren | `intervention_library.dart` | ✓ erledigt |
| 3.3 | RSA/ABCDE Template als Intervention implementieren | `intervention_library.dart` | ✓ erledigt |
| 3.4 | Eigenentwickelte Belastungsskala (SelbsteinschätzungsSkala) | `belastungsskala.dart` | ✓ erledigt |
| 3.5 | Atemtimer Pre-Step (optional) | low priority, offen | offen |

---

## Abschnitt 6: Verifikation

### Checklist — Vollständigkeit der Gap-Analyse

- [x] Alle Abschnitte von `konzeptv2neu.md` wurden abgedeckt:
  - [x] Executive Summary / Produktpositionierung
  - [x] Quellen- und Lizenzanalyse
  - [x] Template-Extraktion (ABC-3, RSA/ABCDE, Depressionsskala)
  - [x] Adaptierter App-Konzeptentwurf
  - [x] Technischer Plan mit Worksheet-Engine
  - [x] Privacy/Regulatorik
  - [x] Roadmap und Risiken
- [x] Aktionsliste ist priorisiert (1–3)
- [x] Offene rechtliche Fragen sind explizit markiert (→ `05_rechteklärung_lizenzen.md`)
- [x] State-Klassifikations-Entscheidung ist begründet
- [x] Payload-Strategie ist offen markiert (Architektur-Entscheidung ausstehend)
