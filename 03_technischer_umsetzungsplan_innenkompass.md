---
title: "Innenkompass - Technischer Umsetzungsplan"
document_type: "technical-implementation-plan"
project: "Innenkompass"
version: "1.0"
status: "draft"
date_created: "2026-03-16"
last_updated: "2026-03-16"
language: "de"
author: "OpenAI / ChatGPT"
audience:
  - "Entwicklung"
  - "Technische Planung"
  - "Architektur"
  - "QA"
purpose: "Technische Architektur, Komponenten, Datenmodell, Umsetzungsphasen und technische Risiken des MVP."
tags:
  - "flutter"
  - "riverpod"
  - "drift"
  - "sqlite"
  - "mobile architecture"
  - "implementation plan"
---

# Innenkompass
## Technischer Umsetzungsplan

# 1. Technische Zielsetzung

Innenkompass wird als **lokal-first, regelbasiertes mobiles System** umgesetzt.

Das bedeutet im MVP:
- keine KI
- kein Pflicht-Backend
- keine Cloud-Abhängigkeit
- keine externe Gesundheitsdatenverarbeitung
- keine generative Interpretation

Die App soll vollständig auf dem Gerät funktionieren und aus fünf Kernsystemen bestehen:

1. Erfassungssystem
2. Zustands- und Regelengine
3. Interventionssystem
4. Verlaufs- und Musteranalyse
5. Sicherheits- / Krisenmodul

---

# 2. Empfohlener Tech-Stack

## Frontend
- **Flutter**
- **Dart**

## State Management
- **Riverpod**

## Navigation
- **GoRouter**

## Lokale Datenbank
- **Drift + SQLite**

## Sichere lokale Speicherung
- **flutter_secure_storage**

## Lokale Erinnerungen
- **flutter_local_notifications**

## Optionaler App-Schutz
- **local_auth**

---

# 3. Warum Flutter?

Flutter ist für dieses Produkt sinnvoll, weil es:
- eine kontrollierte mobile UI ermöglicht
- ruhige Schrittflüsse gut unterstützt
- Android und iOS aus einer Codebasis erlaubt
- mit lokaler Speicherung gut harmoniert
- stabile, berechenbare Interaktionen ermöglicht

React Native wäre möglich, aber Flutter ist für dieses Produkt meist die sauberere Wahl. Hier brauchst du keine halbe Webplattform auf dem Handy, sondern kontrollierte Abläufe.

---

# 4. Architekturprinzip

Die App wird modular aufgebaut, ohne unnötig überkomplex zu werden.

## Vier Schichten
1. **Presentation**
   Screens, Widgets, Navigation, visuelle Komponenten

2. **Application**
   Use Cases, Controller, Flow-Steuerung

3. **Domain**
   Modelle, Zustände, Regeln, Interventionslogik

4. **Data**
   Datenbank, DAOs, Repositories, Mapper, Storage

---

# 5. Projektstruktur

```text
lib/
  app/
    app.dart
    router.dart
    theme/
      app_theme.dart
      colors.dart
      typography.dart

  core/
    constants/
    utils/
    error/
    extensions/
    logging/

  domain/
    models/
      situation_entry.dart
      intervention.dart
      pattern_summary.dart
      crisis_plan.dart
      user_settings.dart
    enums/
      emotion_type.dart
      impulse_type.dart
      context_type.dart
      system_state.dart
      intervention_type.dart
    rules/
      rule_condition.dart
      rule_result.dart
      rule_engine.dart
      crisis_detector.dart
    services/
      pattern_analyzer.dart
      state_classifier.dart
      intervention_selector.dart

  data/
    db/
      app_database.dart
      tables/
        situation_entries.dart
        user_settings.dart
        crisis_plan.dart
      dao/
        situation_entry_dao.dart
        settings_dao.dart
        crisis_plan_dao.dart
    repositories/
      situation_repository_impl.dart
      settings_repository_impl.dart
      crisis_repository_impl.dart
    mappers/
      situation_mapper.dart

  application/
    usecases/
      create_situation_entry.dart
      classify_state.dart
      generate_intervention_plan.dart
      save_reflection.dart
      get_pattern_summary.dart
      update_crisis_plan.dart
    controllers/
      new_situation_flow_controller.dart
      history_controller.dart
      pattern_controller.dart
      settings_controller.dart
      crisis_controller.dart

  features/
    onboarding/
    home/
    new_situation/
      screens/
      widgets/
      state/
    intervention/
      screens/
      widgets/
    history/
    patterns/
    crisis/
    settings/

  shared/
    widgets/
    components/
    forms/
```

---

# 6. Zentrale technische Systeme

## 6.1 Situations-Erfassungssystem

### Aufgabe
Belastende Situationen Schritt für Schritt erfassen.

### Technische Umsetzung
- mehrstufiger Flow
- Formular-State mit Riverpod
- Draft-State für unvollständige Eingaben
- optionale Zwischenspeicherung

### Erfasste Daten
- Beschreibung
- Kontext
- Zeitpunkt
- Hauptemotion
- Intensität
- Körperanspannung
- automatischer Gedanke
- Impuls
- tatsächliches Verhalten

### Empfehlung
Nicht jeden Zwischenschritt direkt in die Datenbank schreiben.
Stattdessen:
- NewSituationDraft
- NewSituationFlowController
- Persistenz erst bei Abschluss oder explizitem Autosave

---

## 6.2 Zustandsklassifikation

### Aufgabe
Bestimmen, welcher logische Zustand gerade vorliegt.

### Mögliche Zustände
- acute_activation
- reflective_ready
- rumination
- conflict
- self_devaluation
- overwhelm
- crisis

### Input
- Intensität
- Körperanspannung
- Emotion
- Gedanke
- Impuls
- Verhalten
- Kontext

### Umsetzung
Eine zentrale StateClassifier-Klasse übernimmt diese Logik.

**Wichtig:**
- nicht in Widgets verstreuen
- klar testbar
- deterministisch

---

## 6.3 Regelengine

### Aufgabe
Aus Zustand und Eingaben einen Interventionspfad ableiten.

### Prinzip
Wenn Zustand X und Merkmal Y, dann Interventionsplan Z

### Beispiel
Wenn:
- Zustand = Konflikt
- Emotion = Wut
- Impuls = Kontern
- Intensität = hoch

Dann:
- Impulspause
- Regulation
- Fakt-vs-Deutung
- Kommunikationshilfe

### Empfehlung
Regeln im MVP direkt als strukturierte Dart-Objekte definieren, nicht als komplexe JSON-Regelwelt. Man kann sich auch freiwillig Schmerzen bauen, aber muss nicht.

---

## 6.4 Interventionssystem

### Aufgabe
Konkrete Hilfen bereitstellen und rendern.

### Intervention als Datenobjekt
- Typ
- Titel
- Kurzbeschreibung
- Schritte
- Dauer
- empfohlene Zustände
- empfohlene Emotionen

### Beispielstruktur
```dart
{
  id,
  type,
  title,
  summary,
  steps[],
  estimatedDurationSec,
  recommendedForStates[],
  recommendedForEmotions[]
}
```

### Kategorien
- Regulation
- Fakt-vs-Deutung
- Impulspause
- Grübelunterbrechung
- Kommunikationshilfe
- Überforderungsstruktur
- Selbstabwertungscheck

---

## 6.5 Verlaufs- und Musteranalyse

### Aufgabe
Aus mehreren Einträgen verständliche Muster ableiten.

### Keine KI nötig
Die Analyse basiert auf:
- Häufigkeiten
- Durchschnittswerten
- einfachen Trends

### Mögliche Auswertungen
- häufigste Emotionen
- häufigste Kontexte
- häufigste Impulse
- meistgenutzte Interventionen
- am hilfreichsten bewertete Interventionen
- Intensität vorher/nachher
- Entwicklung über Zeit

### Service
PatternAnalyzer → PatternSummary

---

## 6.6 Krisenmodul

### Aufgabe
Bei Risikosignalen auf Sicherheit umschalten.

### Umsetzung
- separater CrisisDetector
- eigener Krisenscreen
- lokale Speicherung von Notfallkontakten
- klar priorisierte Safety-Aktionen

### MVP-Regel
Keine freie Textanalyse mit Pseudo-Intelligenz.
Krisenpfade werden über:
- explizite User-Auswahl
- Krisenflag
- klar definierte Signale
aktiviert.

---

# 7. Datenbank und Persistenz

### Empfehlung
Drift + SQLite

### Vorteile
- stabil
- migrationsfähig
- typisiert
- lokal
- gut testbar

### Tabellen

#### situation_entries
- id
- created_at
- updated_at
- context_type
- person_type
- description
- intensity_before
- body_activation_before
- primary_emotion
- secondary_emotion
- body_signals_json
- automatic_thought
- impulse_type
- actual_behavior
- system_state
- fact_text
- interpretation_text
- evidence_for
- evidence_against
- alternative_explanation
- need_type
- intervention_type
- intervention_id
- next_step_type
- next_step_text
- intensity_after
- body_activation_after
- clarity_after
- helpfulness_rating
- follow_up_note
- crisis_flag

#### user_settings
- id
- language
- reminders_enabled
- reminder_time
- discreet_notifications
- passcode_enabled
- theme_mode
- onboarding_done

#### crisis_plan
- id
- warning_signs_json
- coping_steps_json
- personal_contacts_json
- professional_contacts_json
- safe_environment_notes

#### draft_entries (optional)
- draft_id
- current_step
- payload_json
- updated_at

---

# 8. State Management

### Empfehlung
Riverpod

### Zentrale Controller / Provider

#### newSituationFlowController
Verwaltet:
- aktuellen Schritt
- Draft-Daten
- Validierung
- Navigation innerhalb des Flows
- Finalisierung

#### stateClassifierProvider
Liefert den erkannten Zustand

#### interventionPlanProvider
Erzeugt den passenden Interventionsplan

#### historyController
Lädt, filtert und löscht Verlauf

#### patternController
Berechnet Musterübersichten

#### crisisController
Verwaltet Krisenplan und Sicherheitsdaten

---

# 9. Navigation

### Empfehlung
GoRouter

### Haupt-Routen
- /
- /onboarding
- /home
- /new-situation/step-1
- /new-situation/step-2
- /new-situation/step-3
- /intervention
- /history
- /history/:id
- /patterns
- /crisis
- /settings

### Navigationsprinzip
Der Neue-Situation-Flow soll kontrolliert gesteuert werden, nicht über lose Push/Pop-Ketten. Sonst bricht der Ablauf beim ersten etwas komplexeren Rücksprung auseinander.

---

# 10. Screen-zu-Technik-Zuordnung

### Home Screen
**Technisch:**
- letzte Einträge laden
- Primär-CTA anzeigen
- Krisen-Shortcut bereitstellen

### Neue-Situation-Flow
**Technisch:**
- Draft-Modell
- Schrittvalidierung
- Fortschrittsanzeige
- State-Erhalt

### Zustandsentscheidung
**Technisch:**
- StateClassifier ausführen
- Zustand setzen
- Folgeschritt bestimmen

### Intervention Screen
**Technisch:**
- InterventionPlan laden
- Schritte rendern
- Abschluss speichern

### Verlauf
**Technisch:**
- Liste
- Filter
- Detailansicht
- Löschen / Ergänzen

### Muster
**Technisch:**
- lokale Auswertung aus DB
- textliche Insights
- optional einfache Visualisierung

### Krisenscreen
**Technisch:**
- statischer sicherer Screen
- Kontakte lokal
- Direktaktionen wie Anrufen / Anzeigen

---

# 11. Logik der Regelengine

### Pipeline
1. Eingaben normalisieren
2. Krisenprüfung
3. Hauptzustand bestimmen
4. Interventionspfad wählen
5. passende Intervention laden
6. UI rendern

### Beispiel

**Input:**
- Emotion = Wut
- Intensität = 8
- Körperanspannung = 7
- Impuls = kontern
- Kontext = Arbeit

**Output:**
- system_state = conflict
- intervention_plan = pause + regulation + fact_check + communication

### Prinzip
Gleicher Input → gleicher Output.
Sonst ist es kein System, sondern eine Laune in Softwareform.

---

# 12. Interventionsdarstellung

Jede Intervention besteht aus einzelnen Schritten.

### Beispielmodell InterventionStep
```dart
{
  type,
  title,
  body,
  durationSec,
  options[]
}
```

### Typen
- text
- breathing
- timer
- reflection_question
- selection
- action_prompt

### Vorteil
Viele Interventionen können über einen generischen Renderer dargestellt werden, statt jede Übung als Sonderfall zu bauen.

---

# 13. Sicherheit und Datenschutz technisch

### MVP-Ansatz
- lokal-first
- möglichst keine Drittanbieter-SDKs
- keine Werbe- oder Tracking-SDKs
- sensible Pushes anonymisieren
- App-Lock optional

### Schutzmaßnahmen
- lokaler PIN/Biometrie-Schutz optional
- kein Klartext in Notifications
- Datenlöschung in Einstellungen
- manueller Export statt Cloud-Pflicht

### Verschlüsselung
MVP-tauglich:
- SQLite lokal
- sensible Werte in flutter_secure_storage
- optional später verschlüsselte DB

---

# 14. Erinnerungen technisch

### Empfehlung
Nur lokale Notifications

### Typen
- Reflexions-Reminder
- Erinnerung an unvollständigen Eintrag
- optionaler Abendrückblick

### Umsetzung
- flutter_local_notifications
- Zeiten in user_settings
- diskrete Texte

### Wichtige Regel
Kein Streak-System. Kein Verhaltensdruck. Keine digitalisierte Schuldmaschine.

---

# 15. Tests

### Unit Tests
- StateClassifier
- CrisisDetector
- PatternAnalyzer
- InterventionSelector

### Widget Tests
- Formularschritte
- Validierung
- Interventionsscreen
- Verlaufsliste

### Integration Tests
- vollständiger Situationseintrag
- Zustandswechsel
- Speichern und Wiederöffnen
- Krisenpfad

### Beispiel-Testfälle
- Wut hoch + kontern → Konfliktpfad
- Angst mittel + Grübeln → Grübelpfad
- Überforderung + Vermeidung → Overwhelm-Pfad
- Krisenflag → Krisenscreen

---

# 16. Technische Umsetzungsphasen

### Phase 1: Fundament

**Ziel:** Basisarchitektur und App-Gerüst

**Aufgaben:**
- Flutter-Projekt aufsetzen
- Theme, Routing, Riverpod-Basis
- Drift einrichten
- Basismodelle und Repositories
- Onboarding + Home Skeleton

---

### Phase 2: Neuer-Situation-Flow

**Ziel:** Kern-Use-Case lauffähig

**Aufgaben:**
- Draft-Modell
- Schritt-Screens
- Validierung
- Finalisierung in SituationEntry

---

### Phase 3: Zustandsklassifikation + Regelengine

**Ziel:** App reagiert sinnvoll

**Aufgaben:**
- StateClassifier
- CrisisDetector
- Regeln definieren
- InterventionSelector
- Kernpfade umsetzen:
  - Konflikt
  - Grübeln
  - Überforderung
  - Selbstabwertung
  - akute Aktivierung

---

### Phase 4: Interventionen

**Ziel:** konkrete Hilfe rendern

**Aufgaben:**
- Interventionsdatenmodell
- generischer Step-Renderer
- Interventionsbibliothek
- Nachbewertung

---

### Phase 5: Verlauf + Muster

**Ziel:** Lernsystem herstellen

**Aufgaben:**
- Verlaufsliste
- Detailscreen
- Filter
- PatternAnalyzer
- Muster-Screen

---

### Phase 6: Krisenbereich + Einstellungen

**Ziel:** Sicherheit und Produktreife

**Aufgaben:**
- Krisenplan
- Kontakte
- diskrete Notifications
- App-Lock optional
- Daten löschen / exportieren

---

# 17. Technische Risiken

### 1. Zu viel Freitext
**Problem:**
- schwer auswertbar
- unklare Zustandslogik

**Lösung:**
- strukturierte Felder
- Auswahlchips
- Freitext nur ergänzend

---

### 2. Regelengine wird unübersichtlich
**Problem:**
- schwer wartbar
- Debugging unerquicklich

**Lösung:**
- wenige Hauptzustände
- klare Prioritäten
- gute Tests

---

### 3. Zu viele Sonderfälle pro Screen
**Problem:**
- UI wird instabil
- Wiederverwendung sinkt

**Lösung:**
- generische Komponenten
- standardisierte Flows
- gemeinsamer Intervention Renderer

---

### 4. Zu frühe Cloud-Anbindung
**Problem:**
- unnötige Komplexität
- Datenschutzlast vor Produktfit

**Lösung:**
- lokal-first

---

# 18. Was für V1 bewusst NICHT gebaut wird

- freie Textanalyse durch KI
- Chatoberfläche
- Social Feed
- Cloud-Accounts
- Therapeuten-Dashboard
- Wearables
- komplizierte Personalisierung
- aufgeblasene Analytics- oder Chart-Spielereien

Der Kern muss zuerst belastbar funktionieren.

---

# 19. Zielzustand von V1

Am Ende des MVP muss möglich sein:

- Nutzer startet neue Situation
- Eingaben werden als Draft gehalten
- System klassifiziert Zustand
- Regelengine wählt Interventionsplan
- Intervention wird Schritt für Schritt gerendert
- Nutzer bewertet die Wirkung
- Eintrag wird gespeichert
- Verlauf zeigt alte Einträge
- Muster werden lokal berechnet
- Krisenscreen ist jederzeit erreichbar

---

# 20. Zusammenfassung

Innenkompass wird technisch sinnvoll umgesetzt als:

- lokal-first Mobile App
- Flutter-basiert
- regelbasiert statt KI-getrieben
- mit klarer Zustandslogik
- mit generischem Interventionssystem
- mit lokaler Persistenz und Musteranalyse

## Kurzfassung

Baue die App als lokal-first Flutter-App mit regelbasierter Zustands- und Interventionslogik, Drift-Speicherung, Riverpod-State-Management und einem generischen, geführten Flow-System statt freier KI-Interaktion.
