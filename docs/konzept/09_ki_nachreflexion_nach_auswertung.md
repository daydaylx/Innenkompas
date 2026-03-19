# Innenkompas – Konzept für KI-Nachreflexion nach der Auswertung

## Ziel des Features

Die KI-Nachreflexion soll Nutzer **nach einem bereits erfassten Eintrag** dabei unterstützen, das Geschehen **geordnet, begrenzt und handlungsorientiert** zu reflektieren.

Sie ist **kein offener KI-Chat** und **kein therapeutischer Ersatz**.
Sie soll nicht endlos analysieren, sondern helfen, aus einem belastenden Ereignis einen **klaren, brauchbaren Erkenntnisschritt** zu machen. Also aus Chaos zumindest halbwegs verwertbares Material machen. Man muss ja irgendwo anfangen.

---

## Nicht-Ziele

Die KI-Nachreflexion soll **nicht**:

- akute Eskalationen weiter aufwühlen
- offene Dauergespräche erzeugen
- Diagnosen liefern oder andeuten
- Schuld verteilen
- Menschen oder Beziehungen bewerten
- in instabilen Momenten tiefe Ursachenanalyse erzwingen
- Grübeln verstärken
- wie ein normaler Messenger-Chat funktionieren

---

## Kernprinzip

### Die KI ist kein freier Chat, sondern eine geführte Nachreflexion

Das Feature ist ein **strukturierter Mini-Dialog** mit:

- klarer Aufgabe
- klarer Begrenzung
- klarem Ende
- speicherbarem Ergebnis

Die KI soll nicht einfach "noch ein bisschen drüber reden", sondern gezielt helfen, diese Fragen zu klären:

1. Was war hier eigentlich los?
2. Was war Trigger und was war Hintergrundproblem?
3. Wo lag der früheste Kipppunkt?
4. Was wäre ein realistischer anderer Schritt gewesen?
5. Was ist jetzt hilfreicher als weiteres Grübeln?

---

## Position im Produkt

### Bereich auf der Auswertungsseite

Nach der normalen Auswertung erscheint ein neuer Abschnitt:

**Mit KI weiter sortieren**

### Kurzbeschreibung

> Die KI hilft beim Strukturieren deines Eintrags.
> Bei hoher Anspannung bleibt der Fokus zuerst auf Stabilisierung, nicht auf tiefer Analyse.

---

## Grundlogik: Zwei Zustände sauber trennen

### Zustand 1: Akut
Ziel:
- beruhigen
- stabilisieren
- unterbrechen
- Sicherheit priorisieren

### Zustand 2: Mit Abstand
Ziel:
- verstehen
- Muster erkennen
- realistische Alternative formulieren
- Lernpunkt ableiten

Diese Trennung ist Pflicht.
Ohne sie baut man kein Reflexionsfeature, sondern eine digitalisierte Grübelschleife mit hübschen Buttons.

---

## Verfügbare KI-Modi

Nach der Auswertung werden **keine freien Texteingaben** sofort geöffnet.
Stattdessen gibt es klar definierte Modi.

---

### Modus A: Verstehen

#### Ziel
Die KI hilft, den **Mechanismus hinter dem Geschehen** zu erkennen.

#### Leitfrage
**Was war hier eigentlich los?**

#### Fokus
- Trigger vs. Hintergrundproblem
- Voranspannung
- Gedankenspur
- innerer verletzter Punkt
- vermutete Hauptmechanik

#### Ergebnis
- wahrscheinlichster Kern
- vermuteter Hintergrundfaktor
- kurzer Lernsatz

---

### Modus B: Anders abbiegen

#### Ziel
Die KI hilft, den **frühesten nutzbaren Abzweig** zu erkennen.

#### Leitfrage
**Wo hätte ich realistischer anders reagieren können?**

#### Fokus
- Kipppunkt
- Frühwarnsignal
- kleiner alternativer Schritt
- Vorbereitung auf ähnliche Situationen

#### Ergebnis
- frühester Kipppunkt
- realistische Alternative
- nächster Mini-Schritt

---

### Modus C: Kurz ordnen

#### Ziel
Die KI soll **ohne Tiefenanalyse** knapp und brauchbar strukturieren.

#### Leitfrage
**Hilf mir, das kurz und klar zu ordnen.**

#### Fokus
- kurze Zusammenfassung
- keine tiefe Analyse
- kein langes Gespräch
- nur Kern + nächster Schritt

#### Ergebnis
- 2 bis 4 Sätze Zusammenfassung
- nächster sinnvoller Schritt
- optional ein Merksatz

---

### Modus D: Erst runterkommen

#### Ziel
Nicht reflektieren, sondern **stabilisieren**.

#### Leitfrage
**Was hilft jetzt mehr als weiteres Nachdenken?**

#### Fokus
- Unterbrechung
- Distanz
- Körperregulation
- sichere Person
- keine Tiefenanalyse

#### Ergebnis
- 1 akute Einordnung
- 1 Stabilisierungsschritt
- 1 Hinweis auf spätere Reflexion

---

## Freischaltlogik der Modi

### Direkte Freischaltung von Verstehen / Anders abbiegen / Kurz ordnen nur wenn:

- Belastung nicht extrem hoch ist
- Körperanspannung nicht extrem hoch ist
- kein starker Kontrollverlust vorliegt
- kein Hinweis auf akute Selbst- oder Fremdgefährdung besteht
- keine klare Überforderung gegen weitere Analyse spricht

---

## Sicherheitsgating bei hoher Eskalation

### Sicherheitspriorität greift, wenn zum Beispiel:

- Belastung `>= 9`
- Körperanspannung `>= 9`
- tatsächliches Verhalten Dinge werfen, massive Eskalation oder klaren Kontrollverlust enthält
- Eintrag starke Desorganisation zeigt
- Nutzerantworten sehr diffus oder überfordert sind
- Auswertungslogik den Fall als **akute Eskalation**, **starken inneren Druck** oder **sicherheitsrelevanten Moment** einstuft

### Dann gilt:

- **Verstehen** wird deaktiviert oder auf später verschoben
- **Anders abbiegen** wird deaktiviert oder auf später verschoben
- **Kurz ordnen** wird nur reduziert angeboten oder ebenfalls gesperrt
- **Erst runterkommen** wird priorisiert angezeigt
- zusätzlicher Button:
  **Später mit Abstand reflektieren**

---

## UX auf der Auswertungsseite

### Fall A: normale Nutzung

Buttons / Karten:

- **Verstehen**
- **Anders abbiegen**
- **Kurz ordnen**

### Fall B: hohe Eskalation

Buttons / Karten:

- **Erst runterkommen**
- **Später mit Abstand reflektieren**

Zusatzhinweis:

> Gerade wirkt Stabilisierung hilfreicher als weitere Analyse.

---

## Gesprächsarchitektur

## Keine endlosen Chats

Jede KI-Nachreflexion ist eine **Mini-Session**.

### Harte Grenzen

- maximal **5 bis 8 Nachrichten insgesamt**
- pro KI-Antwort nur **eine Hauptfrage**
- keine langen Monologe
- nach spätestens **3 inhaltlichen Schleifen** muss verdichtet werden
- jede Session endet mit einer **Ergebnis-Karte**

---

## Standardstruktur jeder KI-Session

### Schritt 1: KI spiegelt knapp den Eintrag
Die KI beginnt mit einer kurzen Beobachtung auf Basis des Eintrags.

Beispiele:
- hohe Voranspannung
- Trigger wirkt wie letzter Tropfen
- Reaktion war impulsiv
- eigentliches Thema scheint größer als der Anlass

**Länge:** 1 bis 3 Sätze

---

### Schritt 2: KI stellt genau eine fokussierte Rückfrage
Keine Sammelfrage, kein Fragenhagel.

Die Rückfrage muss direkt zum gewählten Modus passen.

---

### Schritt 3: Nutzer antwortet knapp
Freitext, optional mit Hilfestartern:

- „Ich glaube eher ...“
- „Eigentlich ging es darum, dass ...“
- „Der Punkt, wo es kippte, war ...“

---

### Schritt 4: KI verdichtet
Die KI formuliert daraus:

- Kern
- möglicher Kipppunkt
- alternative Abzweigung oder nächster Schritt

---

### Schritt 5: Ergebnis-Karte
Die Session endet mit einer speicherbaren Zusammenfassung.

---

## Modusspezifische Gesprächslogik

### A. Verstehen

#### KI-Start
Die KI benennt:
- Voranspannung
- Trigger vs. Hintergrund
- Unsicherheit ausdrücklich, wenn nötig

#### Rückfrage
**Was war deiner Meinung nach schon vor dem eigentlichen Moment das größere Thema?**

#### Ziel
Nicht maximal tief, sondern maximal klar.

#### Abschluss
- Kern
- Hintergrundthema
- Merksatz

---

### B. Anders abbiegen

#### KI-Start
Die KI benennt:
- wahrscheinlichen Kipppunkt
- dass Veränderung früher ansetzt als beim Endverhalten

#### Rückfrage
**Welcher kleine Schritt wäre realistischer gewesen: kurz stoppen, Abstand schaffen, etwas sagen oder etwas anderes?**

#### Ziel
Handlungsfähigkeit statt Ursachenkreisen.

#### Abschluss
- frühester Kipppunkt
- realistische Alternative
- nächster Übungsschritt

---

### C. Kurz ordnen

#### KI-Start
Die KI gibt eine knappe Einordnung.

#### Rückfrage
**Soll ich dir daraus eher einen kurzen Lernsatz oder einen nächsten kleinen Schritt formulieren?**

#### Ziel
Minimale Belastung, maximale Klarheit.

#### Abschluss
- 2 bis 4 Sätze Gesamtfazit
- nächster Schritt

---

### D. Erst runterkommen

#### KI-Start
Die KI spiegelt:
- hohe Anspannung
- dass Analyse gerade nicht Priorität hat

#### Rückfrage
**Was wäre gerade am ehesten machbar: Abstand, Wasser, kurze Bewegung, stille Pause oder sichere Person?**

#### Ziel
Nervensystem runter, nicht Analyse aufblasen.

#### Abschluss
- 1 Stabilisierungsschritt
- 1 Mini-Hinweis für später
- Option: später reflektieren

---

## Ergebnis der KI-Nachreflexion

Am Ende jeder Session wird eine **strukturierte Ergebnis-Karte** erzeugt.

### Pflichtfelder

#### 1. Wahrscheinlichster Kern
Beispiel:
> Wahrscheinlich ging es nicht nur um das Missgeschick, sondern auch um bereits vorhandene Überforderung.

#### 2. Frühester Kipppunkt
Beispiel:
> Gekippt ist es wahrscheinlich schon, als du gemerkt hast, dass dich selbst Kleinigkeiten stark gereizt haben.

#### 3. Realistische Alternative
Beispiel:
> Ein machbarer anderer Schritt wäre gewesen, kurz Abstand zu schaffen statt sofort zu reagieren.

#### 4. Nächster sinnvoller Schritt
Beispiel:
> Jetzt hilfreicher als weiteres Grübeln ist erst körperlich runterzufahren und das Thema später neu anzusehen.

### Optionales Feld

#### 5. Merksatz für ähnliche Situationen
Beispiel:
> Nicht die Kleinigkeit war das ganze Problem, sondern ein voller Kopf plus Trigger.

---

## Speicherung im Datenmodell

Die KI-Nachreflexion darf nicht als lose Chatblasen versanden.

### Pro Eintrag speicherbar

```ts
type AIReflectionMode = "understand" | "redirect" | "organize" | "stabilize";
type AIReflectionStatus = "not_started" | "in_progress" | "completed" | "deferred";

interface EntryAIReflection {
  aiReflectionAvailable: boolean;
  aiReflectionMode?: AIReflectionMode;
  aiReflectionStatus: AIReflectionStatus;

  aiReflectionSummary?: string;
  aiReflectionLikelyCore?: string;
  aiReflectionEarlyTurningPoint?: string;
  aiReflectionAlternative?: string;
  aiReflectionNextStep?: string;
  aiReflectionMantra?: string;

  aiReflectionDeferredUntil?: string;
  aiReflectionCompletedAt?: string;
}
```

---

## Funktion: Später mit Abstand reflektieren

### Pflichtfunktion

Wenn ein Eintrag zu akut wirkt, muss die KI-Nachreflexion **bewusst verschoben** werden können.

### Button

**Später mit Abstand reflektieren**

### Wirkung

- Eintrag wird markiert
- KI-Reflexion startet nicht sofort
- Detailansicht zeigt später:
  **Für Nachreflexion vorgemerkt**

### Sinn

Sehr wichtig, weil Reflexion im Peak oft nur neue Verwirrung oder neue Selbstabwertung erzeugt.

---

## Regeln für die KI-Antworten

### Die KI darf

- den Eintrag knapp spiegeln
- Zusammenhänge vorsichtig benennen
- Hypothesen formulieren
- Struktur geben
- realistische Alternativen vorschlagen
- bei hoher Belastung Stabilisierung priorisieren

### Die KI darf nicht

- diagnostizieren
- pathologisieren
- Schuld verteilen
- Beziehungen bewerten
- Personen charakterlich einordnen
- Kindheitstheorien aufmachen
- absolute Aussagen treffen
- endlos nachbohren
- akute Eskalation durch Tiefenanalyse verstärken

---

## Sprachregeln für die KI

### Ton

- ruhig
- konkret
- knapp
- alltagssprachlich
- nicht beschämend
- nicht übergriffig

### Verbotene Tendenzen

- „Das zeigt, dass du ... bist“
- „Offenbar liegt hier ... vor“
- „Du musst jetzt erkennen, dass ...“
- aufgeblasener Therapie-Sound
- absolute Sicherheit bei dünner Datenlage

### Erlaubte Formulierungen

- „Es wirkt so, als ...“
- „Möglich ist, dass ...“
- „Der Eintrag spricht eher dafür, dass ...“
- „Vielleicht war nicht nur der Auslöser entscheidend, sondern auch ...“

---

## Inhalte, die V1 ausdrücklich nicht enthalten soll

### Nicht Ziel von V1

- freier Dauerchat
- Beziehungsanalyse
- diagnostische Einordnung
- KI als Krisenintervention
- therapeutischer Gesprächsersatz
- komplexe Verlaufsgespräche über viele Tage
- automatischer Vergleich vieler alter Einträge
- offene Langzeitbegleitung

Für V1 wäre das unnötig riskant und fachlich unsauber. Mehr Features heißt nicht automatisch mehr Qualität. Menschheit lernt es nie.

---

## UI-Komponenten

### A. Auswertungsseite

Neuer Abschnitt:
**Mit KI weiter sortieren**

Enthält:

- Modus-Karten
- Status-Hinweis
- Sperrhinweis bei hoher Eskalation

---

### B. KI-Reflexionsscreen

Bestandteile:

- Header mit Modusname
- kurzer Hinweistext
- Kartenbereich „Was die KI aus dem Eintrag sieht“
- genau eine fokussierte Frage
- Eingabefeld
- Antwortbereich
- Fortschrittsanzeige, z. B. `Schritt 2 von 3`
- Aktionen: `Abbrechen`, `Später merken`
- Abschlusskarte

---

### C. Ergebnis-Karte

Speicherbar im Eintrag:

- Kern
- Kipppunkt
- Alternative
- nächster Schritt
- optional Merksatz

---

### D. Detailansicht

Neuer Abschnitt:
**KI-Nachreflexion**

Enthält:

- gewählten Modus
- Status
- Ergebnis-Karte
- ggf. Vermerk `für später markiert`

---

## Erfolgskriterien

Das Feature ist gelungen, wenn:

- Nutzer besser erkennt, ob der Trigger nur letzter Tropfen war
- Nutzer einen früheren Kipppunkt benennen kann
- Nutzer eine realistische Alternative formulieren kann
- hohe Eskalation **nicht** in freie Tiefenanalyse führt
- das Ergebnis kurz, speicherbar und später nutzbar ist
- die KI nicht schwammig und nicht übergriffig wirkt

---

## Harte Produktregeln in Kurzform

1. Kein offener Chat direkt nach Eskalation.
2. KI-Nachreflexion nur als klar begrenzte Mini-Session.
3. Maximal 5 bis 8 Nachrichten.
4. Pro KI-Antwort nur eine Hauptfrage.
5. Bei hoher Eskalation Stabilisierung vor Analyse.
6. Keine Diagnosen, keine Schuldzuweisungen, keine Pathologisierung.
7. Jede Session endet in einer Ergebnis-Karte.
8. Ergebnis wird strukturiert im Eintrag gespeichert.
9. „Später reflektieren“ muss immer möglich sein.
10. Fokus auf Kern, Kipppunkt, Alternative und nächsten Schritt.

---

## Empfohlene V1-Umsetzung

### V1 enthält

- Moduswahl nach Auswertung
- Sicherheitsgating
- 4 Modi
- 3-Schritt-Mini-Dialog
- Ergebnis-Karte
- Speicherung im Eintrag
- Funktion `Später mit Abstand reflektieren`

### V1 enthält noch nicht

- freien Langzeit-Chat
- tiefe mehrtägige Gesprächsverläufe
- automatische Mustervergleiche über viele Einträge
- Wochenrückblicke auf KI-Basis
- therapeutisch wirkende Gesprächsführung

---

## Empfohlene Produktfassung für V1

### Nach der Auswertung

Bereich:
**Mit KI weiter sortieren**

### Bei normaler Belastung

- Verstehen
- Anders abbiegen
- Kurz ordnen

### Bei hoher Belastung

- Erst runterkommen
- Später mit Abstand reflektieren

### Jede Session

- 1 kurze Spiegelung
- 1 fokussierte Rückfrage
- 1 Verdichtung
- 1 Ergebnis-Karte

---

## Kurzfazit

Die KI-Nachreflexion soll in Innenkompas **kein offener Therapie-Chat**, sondern ein **klar begrenztes, sicheres und handlungsorientiertes Reflexionswerkzeug** sein.

Die sauberste Umsetzung ist:

- **Akutmodus:** stabilisieren
- **Reflexionsmodus:** verstehen
- **Ergebnismodus:** verdichten und speichern

Alles andere wird schnell zu viel Deutung, zu viel Text und zu viel Grübelfutter.
