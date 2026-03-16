---
title: "Innenkompass - PRD MVP"
document_type: "product-requirements-document"
project: "Innenkompass"
version: "1.0"
status: "draft"
date_created: "2026-03-16"
last_updated: "2026-03-16"
language: "de"
author: "OpenAI / ChatGPT"
audience:
  - "Produktmanagement"
  - "Design"
  - "Entwicklung"
  - "QA"
purpose: "Definition des MVP-Funktionsumfangs, der User Flows, Screen-Struktur, Zustandslogik und Abnahmekriterien."
tags:
  - "prd"
  - "mvp"
  - "product design"
  - "mobile app"
  - "emotion regulation"
---

# Innenkompass
## Product Requirements Document (PRD) - MVP V1.0

# 1. Produktzusammenfassung

Innenkompass ist eine mobile-first App zur **situationsbasierten Selbstwahrnehmung und Selbstregulation**.

Die App unterstützt Nutzer dabei, belastende Situationen zu:
- erfassen
- emotional einzuordnen
- strukturiert zu reflektieren
- mit einer passenden Hilfestellung zu beantworten

Der Grundablauf ist:

1. Situation erfassen
2. Belastung einschätzen
3. automatische Reaktion sichtbar machen
4. Fakt und Deutung trennen
5. passende Hilfe auswählen
6. nächsten sinnvollen Schritt festlegen
7. Verlauf speichern und Muster erkennen

Die App arbeitet im MVP **ohne KI**.

---

# 2. Produktziel

## Hauptziel
Nutzer sollen in belastenden Situationen schneller zu:
- Klarheit
- emotionaler Selbstwahrnehmung
- geringerer Impulssteuerung
- besserer Selbstregulation

gelangen.

## Teilziele
- Gefühle präziser benennen
- körperliche Aktivierung einordnen
- Gedanken sichtbar machen
- Fakten von Interpretationen trennen
- passende Reaktionen statt alter Automatismen wählen
- wiederkehrende Muster erkennen

## Nicht-Ziele
Die App soll im MVP nicht:
- Diagnosen stellen
- Therapie ersetzen
- offene therapeutische Gespräche führen
- eine soziale Plattform sein
- komplexe medizinische Krisen abdecken
- eine allgemeine Wellness-App sein

---

# 3. Zielgruppe

## Primäre Nutzer
Erwachsene mit:
- emotionaler Überforderung
- Konfliktbelastung
- Grübelneigung
- impulsiven Reaktionen
- Rückzugstendenz
- Schwierigkeiten bei Selbstwahrnehmung

## Typische Nutzungsszenarien
- Streit oder Kränkung
- Angst nach Nachrichten oder Kontaktsituationen
- Überforderung im Alltag
- Wut und Gereiztheit
- Selbstabwertung nach Fehlern
- soziale Nachbearbeitung durch Grübeln

## Klare Produktgrenzen
Nicht primär gedacht für:
- akute Suizidalität
- Psychosen
- schwere psychiatrische Krisen
- schwere Traumafolgen ohne therapeutische Begleitung

---

# 4. Kernversprechen

**"Wenn dich eine Situation emotional trifft, hilft dir die App dabei, schneller zu verstehen, was in dir passiert, und bewusster zu reagieren."**

---

# 5. Jobs-to-be-done

## Haupt-Job
"Wenn mich etwas emotional trifft, möchte ich schnell sortieren können, was passiert ist und was ich jetzt sinnvoll tun sollte."

## Nebenziele
- "Ich will meine typischen Muster verstehen."
- "Ich will nicht sofort impulsiv reagieren."
- "Ich will erkennen, ob ich gerade interpretiere."
- "Ich will hilfreiche Strategien im Alltag schneller finden."
- "Ich will in kurzer Zeit Unterstützung, ohne mit Text erschlagen zu werden."

---

# 6. Grundlogik des Produkts

## Reaktionsmodell
**Situation → Bewertung → Emotion → Körper → Impuls → Verhalten → Folge**

## Ergänzende Struktur
**Fakt ↔ Interpretation ↔ Bedürfnis ↔ nächster Schritt**

## Hauptmodi
- **Akutmodus**
- **Reflexionsmodus**

---

# 7. MVP-Scope

## Im MVP enthalten
- Onboarding
- Homescreen
- Neue Situation erfassen
- Intensitäts- und Emotionsbewertung
- Gedanken- und Impuls-Erfassung
- Fakt-vs-Deutung-Modul
- regelbasierte Interventionsauswahl
- Interventionsbibliothek
- Nachbewertung
- Verlauf / Historie
- einfache Musterübersicht
- Krisenbereich
- lokale Speicherung

## Nicht im MVP enthalten
- freie KI-Chatfunktion
- Wearable-Anbindung
- Cloud-Pflicht
- Therapeutenportal
- Community
- Diagnostik
- regulatorische Medizinprodukt-Logik
- komplexe Personalisierung

---

# 8. Informationsarchitektur

## Hauptnavigation
1. Start
2. Neue Situation
3. Verlauf
4. Muster
5. Hilfe / Krisenplan
6. Einstellungen

---

# 9. Screen-Liste

## Screen 1: Splash / Einstieg
**Zweck:** App-Start

**Inhalte:**
- Logo
- Name
- kurzer Claim
- Laden lokaler Daten

---

## Screen 2: Onboarding
**Zweck:** Grenzen und Nutzen erklären

**Inhalte:**
- Produktüberblick
- kein Therapieersatz
- Hinweis auf Krisenhilfe
- Datenschutz in einfacher Sprache

**Aktionen:**
- Weiter
- Starten
- Krisenhilfe lesen

---

## Screen 3: Homescreen
**Zweck:** zentraler Ausgangspunkt

**Inhalte:**
- Primärbutton: "Was ist passiert?"
- Sekundärzugang: Verlauf / Rückblick
- letzter Eintrag
- Krisen-Shortcut

**Aktionen:**
- Neue Situation starten
- Verlauf öffnen
- Muster öffnen
- Krisenbereich öffnen

---

## Screen 4: Neue Situation - Ereignis erfassen
**Zweck:** belastende Situation beschreiben

**Felder:**
- Kurzbeschreibung
- Kontext
- Zeitpunkt
- beteiligte Person optional

**Buttons:**
- Weiter
- Abbrechen

---

## Screen 5: Belastung und Emotion
**Zweck:** emotionalen Zustand erfassen

**Felder:**
- Belastungsintensität 1-10
- Körperanspannung 1-10
- Hauptemotion
- Sekundäremotion optional
- Körpersymptome optional

---

## Screen 6: Automatischer Gedanke und Impuls
**Zweck:** erste innere Reaktion erfassen

**Felder:**
- automatischer Gedanke
- erster Impuls
- tatsächliches Verhalten bisher

---

## Screen 7: Zustandsentscheidung
**Zweck:** passenden Pfad bestimmen

**Mögliche Zustände:**
- akut stark aktiviert
- belastet, aber reflektionsfähig
- Grübelmodus
- Konfliktmodus
- Selbstabwertungsmodus
- Überforderungsmodus
- Krisenverdacht

---

## Screen 8A: Akut-Regulation
**Zweck:** Nervensystem runterregen

**Inhalte:**
- Atemübung
- Erdung
- Impulspause
- Reizreduktion

---

## Screen 8B: Fakt-vs-Deutung
**Zweck:** Beobachtung und Deutung trennen

**Felder:**
- Was ist objektiv passiert?
- Was bedeutet das in deinem Kopf?
- Welche Belege gibt es?
- Welche Gegenbelege gibt es?
- Welche alternative Erklärung ist möglich?

---

## Screen 9: Bedürfnis / verletzter Punkt
**Zweck:** herausarbeiten, was innerlich berührt wurde

**Felder:**
- Was wurde bei dir berührt?
  - Respekt
  - Sicherheit
  - Kontrolle
  - Nähe
  - Anerkennung
  - Zugehörigkeit
  - Fairness
  - Ruhe
  - Selbstwert
  - anderes

---

## Screen 10: Passende Hilfestellung
**Zweck:** konkrete Unterstützung geben

**Mögliche Inhalte:**
- Regulation
- Denkstütze
- Kommunikationshilfe
- Grübelunterbrechung
- Überforderungsstruktur
- Akzeptanzhilfe

---

## Screen 11: Nächster Schritt festlegen
**Zweck:** Erkenntnis in Handlung übersetzen

**Optionen:**
- später ruhig ansprechen
- jetzt Pause machen
- nicht senden / nicht reagieren
- Aufgabe in kleinen Schritt teilen
- Kontaktperson anrufen / schreiben
- bewusst loslassen
- später reflektieren

---

## Screen 12: Nachbewertung
**Zweck:** Wirkung erfassen

**Felder:**
- Belastung jetzt 1-10
- Körperanspannung jetzt 1-10
- Klarheit jetzt 1-10
- Hat die Hilfe gepasst?
- Notiz optional

---

## Screen 13: Verlauf
**Zweck:** alte Situationen ansehen

**Inhalte:**
- chronologische Liste
- Filter
- Öffnen / Löschen

---

## Screen 14: Detailansicht eines Eintrags
**Zweck:** vollständige Betrachtung eines Eintrags

**Inhalte:**
- Situation
- Emotion
- Gedanke
- Impuls
- Fakt/Deutung
- Intervention
- Nachbewertung
- nächster Schritt

---

## Screen 15: Muster
**Zweck:** emotionale Wiederholungen sichtbar machen

**Inhalte:**
- häufigste Kontexte
- häufigste Emotionen
- häufigste Impulse
- hilfreiche Interventionen
- Belastungstrends

---

## Screen 16: Krisenbereich / Safety Screen
**Zweck:** Sicherheitsbereich

**Inhalte:**
- Krisenhinweis
- persönliche Notfallkontakte
- professionelle Hilfen
- kurze Krisenschritte

---

## Screen 17: Einstellungen
**Inhalte:**
- Sprache
- Erinnerungen
- Datenschutz / Export / Löschen
- Notfallkontakte
- Schutzcode optional
- diskrete Benachrichtigungen

---

# 10. Felddefinitionen

## Pflichtfelder
- Situationsbeschreibung
- Belastungsintensität
- Hauptemotion
- automatischer Gedanke oder Impuls
- ausgewählte Hilfe

## Optionale Felder
- beteiligte Person
- Körpersymptome
- Sekundäremotion
- Bedürfnis
- Notiz
- späterer Rückblick

## Validierungen
- Kurzbeschreibung: 3-300 Zeichen
- Gedanke: max. 200 Zeichen
- Notiz: max. 500 Zeichen
- Intensität: 1-10
- Emotion: mindestens eine Auswahl

---

# 11. Zustandslogik

## Zustand A: Akut stark aktiviert
**Kriterien:**
- Belastung >= 8
- Körperanspannung >= 7
- Impuls = Angriff / Flucht / Kontrollverhalten

**Folge:**
- zuerst Regulation
- keine tiefe Analyse

---

## Zustand B: Reflexionsfähig
**Kriterien:**
- Belastung 4-7
- Körperanspannung moderat
- strukturierte Angaben möglich

**Folge:**
- kurzer Faktencheck
- Bedürfnis
- passende Hilfe

---

## Zustand C: Grübelmodus
**Kriterien:**
- kreisende Gedanken
- Grübeln / Kontrollieren
- Angst / Scham / Unsicherheit

**Folge:**
- Problem lösbar?
- Handlung oder Begrenzung

---

## Zustand D: Konfliktmodus
**Kriterien:**
- zwischenmenschlicher Konflikt
- Wut / Kränkung / Enttäuschung
- Impuls = kontern / rechtfertigen / Rückzug

**Folge:**
- Impulspause
- Fakt-vs-Deutung
- Kommunikationshilfe

---

## Zustand E: Selbstabwertungsmodus
**Kriterien:**
- Gedanken wie "Ich bin unfähig / peinlich / wertlos"
- Scham / Traurigkeit

**Folge:**
- Perspektivwechsel
- Gegenbelege
- realistischere Bewertung

---

## Zustand F: Überforderungsmodus
**Kriterien:**
- alles-zu-viel-Gefühl
- hohe mentale Last
- Vermeidung / Abschalten

**Folge:**
- Strukturierung
- Priorität
- kleinster nächster Schritt

---

## Zustand G: Krisenverdacht
**Kriterien:**
- klare Risikosignale
- extreme Hoffnungslosigkeit
- Hinweise auf Selbstverletzung

**Folge:**
- Standardflow verlassen
- Krisenhilfe priorisieren

---

# 12. Interventionsbibliothek

## Regulation
- 4/6-Atmung
- Erdung
- Reorientierung
- Impulspause

## Fakt-vs-Deutung
- Was weiß ich sicher?
- Was vermute ich?
- Welche Belege gibt es?
- Welche andere Erklärung ist möglich?

## Impulspause
- nicht senden
- Abstand schaffen
- 10-Minuten-Regel

## Grübelunterbrechung
- Problem lösbar?
- Handlung oder Akzeptanz

## Selbstabwertungs-Check
- Gegenbelege
- Perspektivwechsel
- realistischere Bewertung

## Kommunikationshilfe
- Beobachtung statt Vorwurf
- Gefühl statt Unterstellung
- Wunsch statt Angriff

## Überforderungs-Entlastung
- Gedanken sortieren
- priorisieren
- 1 nächster Schritt

---

# 13. Datenmodell (fachlich)

## UserSettings
- Sprache
- Erinnerungen
- diskrete Notifications
- Schutzcode
- Notfallkontakte

## SituationEntry
- Datum/Uhrzeit
- Kontext
- Beschreibung
- Intensität vor/nach
- Körperanspannung vor/nach
- Emotionen
- Körpersymptome
- automatischer Gedanke
- Impuls
- Verhalten
- Systemzustand
- Fakt
- Interpretation
- Belege
- alternative Erklärung
- Bedürfnis
- Intervention
- nächster Schritt
- Klarheit nachher
- Hilfreichkeitsbewertung
- Notiz
- Krisenflag

## PatternSummary
- Häufigkeiten nach Emotion/Kontext/Impuls
- durchschnittliche Intensität
- hilfreiche Interventionen

## CrisisPlan
- Warnzeichen
- Bewältigungsstrategien
- Kontakte
- Hilfen

---

# 14. Persistenz und Datenschutz

## MVP-Ansatz
- lokal auf dem Gerät
- keine Pflicht-Cloud
- möglichst wenig externe Datenverarbeitung

## Gründe
- Datenschutz
- geringere Komplexität
- schnellerer MVP
- höheres Vertrauen

---

# 15. Erinnerungen / Nudging

## Prinzip
Erinnerungen nur dezent und optional.

## Gute Reminder
- "Zeit für einen kurzen Rückblick."
- "Willst du deinen letzten Eintrag ergänzen?"

## Schlechte Reminder
- "Du hast deine Regulation heute verpasst."
- "3 Tage ohne Nutzung."

Kein Streak-System. Kein Schuldgefühl-Design.

---

# 16. Erfolgsmessung

## Produkt-KPIs
- gestartete Situationen
- Abschlussrate pro Flow
- Abbruchrate pro Screen
- Nutzung Akutmodus vs. Reflexion
- Differenz Intensität vor/nach
- hilfreichste Interventionen
- Wiederkehrrate nach 7/30 Tagen

## UX-KPIs
- Abbruchpunkte
- leer gelassene Felder
- ungenutzte Interventionen
- lange oder verwirrende Pfade

---

# 17. Nicht-funktionale Anforderungen

## Performance
- schneller Start
- flüssige Screen-Wechsel

## Usability
- Einhand-Bedienung
- große Buttons
- wenig Tipparbeit
- klare Sprache

## Accessibility
- Kontraste
- skalierbare Schriftgrößen
- Basis-Screenreader-Support

## Sicherheit
- App-Schutz optional
- diskrete Push-Texte
- keine sensiblen Inhalte auf Sperrbildschirm

---

# 18. MVP-Abnahmekriterien

Das MVP gilt als brauchbar, wenn:

1. ein Nutzer in unter 2 Minuten eine Situation erfassen kann
2. die App daraus einen plausiblen Pfad auswählt
3. mindestens 5 robuste Interventionspfade vorhanden sind
4. Belastung vor und nachher erfasst wird
5. Verlaufseinträge gespeichert und geöffnet werden können
6. einfache Musterübersichten sichtbar sind
7. Krisenhilfe jederzeit erreichbar ist
8. die App ohne KI sinnvoll nutzbar bleibt

---

# 19. Roadmap nach MVP

## V1.1
- mehr Interventionsvarianten
- besserer Verlauf
- Export / Backup

## V1.2
- feinere Personalisierung
- bessere Mustererkennung
- sanfter Tagesrückblick

## V2
- begrenzte KI-Unterstützung
  - Freitext strukturieren
  - Einträge zusammenfassen
  - alternative Formulierungen vorschlagen

## Später
- klinische Pilotierung
- Evaluation
- therapeutische Begleitnutzung
- regulatorische Vorbereitung

---

# 20. Fazit

Das MVP ist bewusst fokussiert.
Der eigentliche Wert liegt nicht in Chat, KI oder Gamification, sondern in einer einzigen Kernleistung:

**Eine belastende Situation in einen geordneten, hilfreichen Regulationsprozess übersetzen.**
