---
title: "Innenkompass - Plan für Auswertung und praktische Tipps"
document_type: "feature-plan"
project: "Innenkompass"
version: "1.0"
status: "draft"
date_created: "2026-03-16"
last_updated: "2026-03-16"
language: "de"
author: "OpenAI / ChatGPT"
audience:
  - "Produktplanung"
  - "Entwicklung"
  - "UX"
  - "Regellogik"
purpose: "Definition eines klaren Plans zur Integration von Auswertung und praktischen Tipps in die App Innenkompass."
tags:
  - "feature"
  - "auswertung"
  - "tipps"
  - "regelbasiert"
  - "emotion regulation"
  - "mvp"
---

# Innenkompass
## Plan für Auswertung und praktische Tipps

# 1. Ziel

Die App soll nach jedem ausgefüllten Arbeitsblatt nicht nur speichern, sondern dem Nutzer auch direkt sagen:

- was an der Situation auffällt
- welches Muster erkennbar ist
- was jetzt praktisch hilfreich wäre

Die Auswertung soll:
- kurz
- verständlich
- handlungsbezogen
- nicht diagnostisch
- nicht übergriffig
sein.

Das Ziel ist, aus der App mehr zu machen als ein digitales Arbeitsblatt oder ein reines Eintragsarchiv.
Die App soll dem Nutzer **einen unmittelbaren, praktischen Rückkanal** geben.

---

# 2. Grundprinzip

Die Auswertung besteht aus drei Ebenen:

## Ebene A: Sofort-Auswertung nach einem Eintrag
Direkt nach dem Ausfüllen eines Arbeitsblatts.

## Ebene B: Situationsbezogene praktische Tipps
Konkrete Hinweise für genau diesen Fall.

## Ebene C: Verlaufsauswertung über mehrere Einträge
Wiederkehrende Muster und hilfreiche Strategien über Zeit.

---

# 3. Was im MVP enthalten sein soll

## Direkt nach jedem Eintrag
- Kurzfazit
- erkannter Hauptzustand
- 2 bis 4 passende Tipps
- ein nächster sinnvoller Schritt

## Im Verlauf
- häufigste Emotionen
- häufigste Auslöser
- häufigste Impulse
- hilfreichste Interventionen
- einfache Musterhinweise

## Nicht im MVP
- Diagnosen
- Persönlichkeitsprofile
- freie KI-Auswertung
- tiefe psychologische Deutungen
- komplizierte Score-Systeme
- therapeutische Simulation

---

# 4. Sofort-Auswertung nach dem Arbeitsblatt

Nach jedem Eintrag erscheint ein kompakter Auswertungsbereich.

## Ziel
Der Nutzer soll direkt verstehen:
- was gerade an seiner Reaktion auffällt
- welche Einordnung sinnvoll ist
- was jetzt praktisch helfen könnte

## Aufbau des Auswertungsblocks

### Karte 1: Was gerade auffällt
Beispiele:
- „Hohe Belastung und starker Rückzugsimpuls“
- „Starke Interpretation bei wenig gesicherten Fakten“
- „Hohe körperliche Anspannung vor der Reaktion“
- „Konflikt mit schneller Rechtfertigungs- oder Angriffsneigung“

### Karte 2: Was das bedeuten könnte
Beispiele:
- „Du warst eher im Alarmmodus als im klaren Denkmodus.“
- „Die Situation wurde vermutlich stark durch Annahmen aufgeladen.“
- „Der erste Impuls war schneller als die sachliche Einordnung.“
- „Dein Gedanke wirkte eher wie eine Befürchtung als wie ein gesicherter Fakt.“

### Karte 3: Was jetzt praktisch helfen kann
Beispiele:
- „Erst Abstand, dann Fakten prüfen.“
- „Nicht sofort antworten.“
- „Nur einen nächsten Schritt wählen.“
- „Eine alternative Erklärung notieren, bevor du weiterdenkst.“

---

# 5. Tippsystem

Die Tipps sollen nicht frei generiert werden, sondern aus einer festen, gut geschriebenen Bibliothek kommen.

## Ziel
Die Tipps sollen:
- konkret
- kurz
- direkt nutzbar
- an der Situation orientiert
sein.

## Grundstruktur der Tipp-Bibliothek

Jeder Tipp erhält passende Tags, z. B.:
- Emotion: Angst
- Emotion: Wut
- Emotion: Scham
- Zustand: Grübeln
- Zustand: Konflikt
- Zustand: Überforderung
- Muster: Rückzug
- Muster: Selbstabwertung
- Muster: Kontrollimpuls
- Aktivierung: hoch
- Faktlage: unsicher

## Auswahlprinzip
Die App zeigt nach einem Eintrag:
- 2 bis 4 passende Tipps
- keine Textwand
- keine allgemeinen Lebensweisheiten
- keine „positiven Affirmationen“ ohne Bezug

---

# 6. Beispielhafte Tipp-Kategorien

## 6.1 Tipps bei Angst
- „Prüfe, ob du gerade Annahmen statt Fakten nutzt.“
- „Formuliere eine alternative Erklärung.“
- „Vermeide impulsives Nachkontrollieren.“
- „Reguliere erst den Körper, bevor du weiter analysierst.“

## 6.2 Tipps bei Wut
- „Reagiere nicht im ersten Impuls.“
- „Trenne Kritik von persönlicher Abwertung.“
- „Schreibe erst auf, was objektiv passiert ist.“
- „Sprich später in Beobachtungen statt Vorwürfen.“

## 6.3 Tipps bei Grübeln
- „Prüfe, ob das Problem gerade lösbar ist.“
- „Wenn ja: wähle einen nächsten Schritt.“
- „Wenn nein: begrenze die Denkschleife bewusst.“
- „Wiederholung ist nicht automatisch Klärung.“

## 6.4 Tipps bei Überforderung
- „Nicht alles gleichzeitig lösen.“
- „Nur einen nächsten Schritt festlegen.“
- „Erst Reize reduzieren, dann planen.“
- „Wenn alles zu viel ist, ist mehr Analyse oft nicht die Lösung.“

## 6.5 Tipps bei Selbstabwertung
- „Trenne Fehler von Selbstwert.“
- „Prüfe Gegenbelege.“
- „Formuliere eine realistischere Alternative.“
- „Würdest du mit einer anderen Person genauso sprechen?“

## 6.6 Tipps bei Konflikten
- „Antworte nicht im ersten Impuls.“
- „Trenne Beobachtung und Unterstellung.“
- „Notiere zuerst den sachlichen Kern.“
- „Wenn nötig: Gespräch verschieben, statt eskalieren.“

---

# 7. Regelbasierte Auswertungslogik

Die App braucht eine klare, testbare Regelmatrix.

## Eingaben, die ausgewertet werden
- Situationstyp / Kontext
- Hauptemotion
- Intensität
- Körperanspannung
- automatischer Gedanke
- Impuls
- bisheriges Verhalten
- Fakt-vs-Deutung-Ergebnis
- gewählte Intervention
- Nachbewertung

## Daraus werden erzeugt
1. erkannter Hauptzustand
2. Kurz-Auswertung
3. passende Tipps

---

# 8. Hauptzustände für die Auswertung

Für den MVP reichen diese Hauptzustände:

## 8.1 Akute Aktivierung
### Merkmale
- hohe Intensität
- hohe Körperanspannung
- Impuls zu Angriff, Flucht oder Kontrollverhalten

### Typische Auswertung
- „Du warst stark aktiviert.“
- „Der Körper war vermutlich schneller als die sachliche Einordnung.“

### Fokus
- Beruhigung
- Impulspause
- keine tiefe Analyse zuerst

---

## 8.2 Grübelmodus
### Merkmale
- kreisende Gedanken
- wiederholtes Durchdenken ohne Fortschritt
- Unsicherheit / Angst / Scham

### Typische Auswertung
- „Du scheinst eher in einer Denkschleife zu sein als in einer Klärung.“

### Fokus
- Begrenzung
- Struktur
- Handlung oder Akzeptanz

---

## 8.3 Konfliktmodus
### Merkmale
- zwischenmenschliche Situation
- Wut, Kränkung oder Enttäuschung
- Impuls zu Rechtfertigung, Angriff oder Rückzug

### Typische Auswertung
- „Die Situation wirkt konfliktgeladen und impulsanfällig.“

### Fokus
- Pause
- Faktenklärung
- Kommunikationshilfe

---

## 8.4 Selbstabwertungsmodus
### Merkmale
- Gedanken wie „Ich bin peinlich / unfähig / wertlos“
- Scham oder Traurigkeit
- Rückzug

### Typische Auswertung
- „Die Belastung scheint stark mit Selbstbewertung verbunden.“

### Fokus
- Gegenbelege
- realistischere Bewertung
- Perspektivwechsel

---

## 8.5 Überforderungsmodus
### Merkmale
- alles-zu-viel-Gefühl
- Vermeidung
- mentale Enge
- hoher Druck

### Typische Auswertung
- „Die Situation wirkt eher überfordernd als unlösbar.“

### Fokus
- Entlastung
- Priorisierung
- kleiner nächster Schritt

---

## 8.6 Interpretationsmodus
### Merkmale
- starke Deutung
- schwache Faktenlage
- Annahmen über andere oder die Zukunft

### Typische Auswertung
- „Du scheinst die Situation gerade eher zu interpretieren als sicher zu wissen.“

### Fokus
- Faktencheck
- alternative Erklärung
- Realitätsprüfung

---

# 9. Sprachstil der Auswertung

Die App soll helfen einzuordnen, nicht psychologisch auftrumpfen.

## Gute Formulierungen
- „Es wirkt so, als …“
- „In dieser Situation scheint …“
- „Dein Eintrag deutet darauf hin …“
- „Auffällig ist hier …“
- „Hilfreich könnte jetzt sein …“

## Schlechte Formulierungen
- „Du hast offensichtlich …“
- „Dein eigentliches Problem ist …“
- „Das kommt sicher aus …“
- „Du bist jemand, der …“

## Grundregel
- keine Diagnosesprache
- keine übertriebene Sicherheit
- keine Tiefendeutung
- keine unnötige Psychologisierung

---

# 10. Verlaufsauswertung über Zeit

Neben der Sofort-Auswertung braucht die App auch langfristige Muster.

## Ziel
Der Nutzer soll erkennen:
- welche Situationen sich wiederholen
- welche Emotionen häufig auftauchen
- welche Reaktionen typisch sind
- was wirklich geholfen hat

## Geplante Verlaufsauswertungen

### Häufigste Auslöser
Beispiele:
- Konflikte
- Kritik
- Unsicherheit in Beziehungen
- Überforderung im Alltag

### Häufigste Emotionen
Beispiele:
- Angst
- Wut
- Scham
- Überforderung

### Häufigste Impulse
Beispiele:
- Rückzug
- Grübeln
- rechtfertigen
- kontrollieren
- kontern

### Hilfreichste Strategien
Beispiele:
- Atemregulation
- Faktencheck
- Abstand
- alternative Erklärung
- Gespräch verschieben

### Einfache Erkenntnissätze
Beispiele:
- „Konflikte mit nahestehenden Personen führen bei dir oft zu Grübeln.“
- „Bei Kritik taucht häufig Selbstabwertung auf.“
- „Wenn deine Körperanspannung hoch ist, helfen dir kurze Regulationen eher als direkte Analyse.“
- „Rückzug ist einer deiner häufigsten ersten Impulse.“

---

# 11. UI-Aufbau für Auswertung und Tipps

## Nach dem Eintrag
Nach dem Arbeitsblatt erscheint ein neuer Bereich:

# Deine Auswertung

## Karte 1: Was auffällt
Kurze Musterzusammenfassung

## Karte 2: Was das bedeuten könnte
Zurückhaltende Einordnung

## Karte 3: Was jetzt hilfreich sein kann
Direkt umsetzbare Richtung

## Bereich: Praktische Tipps
Darunter 2 bis 4 konkrete Tipps

## Bereich: Nächster Schritt
Optional auswählbar:
- Jetzt Pause machen
- Später ansprechen
- Alternative Sicht notieren
- Nicht sofort antworten
- Einen kleinen Handlungsschritt festlegen

---

# 12. Technischer Umsetzungsplan

## Phase 1: Auswertungslogik definieren
- Hauptzustände festlegen
- Regeln dokumentieren
- Textbausteine für Kurz-Auswertungen schreiben
- Tipp-Bibliothek aufbauen

## Phase 2: Datenmodell erweitern
Speichern von:
- erkanntem Zustand
- ausgelieferten Tipps
- gewählter Hilfe
- Hilfreichkeitsbewertung
- nächstem Schritt

## Phase 3: Sofort-Auswertung implementieren
Nach jedem Eintrag:
- Zustand bestimmen
- Kurz-Auswertung erzeugen
- passende Tipps auswählen
- UI anzeigen

## Phase 4: Verlaufsauswertung bauen
- Häufigkeiten berechnen
- Muster ableiten
- verständliche Insight-Karten erzeugen

## Phase 5: Feinschliff
- Sprache vereinfachen
- übergriffige Formulierungen entfernen
- Regeln testen
- Tipps kürzen und verbessern

---

# 13. Erfolgskriterien

Der Bereich ist gut umgesetzt, wenn:

- Nutzer nach dem Eintrag nicht nur „gespeichert“ sehen, sondern echten Mehrwert
- Tipps konkret und nicht generisch wirken
- Auswertungen verständlich und nicht psychologisch aufgeblasen sind
- Verlaufsmuster plausibel und nützlich erscheinen
- Nutzer einen klaren nächsten Schritt ableiten können

---

# 14. Prioritäten

## Priorität 1
Sofort-Auswertung nach dem Blatt

## Priorität 2
Praktische Tipps passend zur Situation

## Priorität 3
Verlaufsmuster über mehrere Einträge

Diese Reihenfolge ist wichtig.
Ein hübscher Verlauf bringt wenig, wenn direkt nach dem Eintrag nur eine sterile Speicherbestätigung erscheint.

---

# 15. Fazit

Die sinnvolle Erweiterung für Innenkompass ist:

1. **regelbasierte Kurz-Auswertung**
2. **saubere Tipp-Bibliothek**
3. **direkte Anzeige nach jedem Eintrag**
4. **spätere Verlaufsmuster**

So entsteht ein echter Rückkanal für den Nutzer, ohne in übergriffige Psychologisierung oder KI-Nebel abzuriften.

Die App bleibt dadurch:
- kontrollierbar
- testbar
- nachvollziehbar
- nützlich
- alltagsnah
