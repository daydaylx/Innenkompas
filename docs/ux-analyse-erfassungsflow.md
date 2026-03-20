# UX-Analyse und Verbesserungsplan: Innenkompass Erfassungsflow

> Kontext: Vollständige UX-Analyse des 4-phasigen Erfassungsflows auf Basis von Code-Inspektion aller Screens, Datenmodelle, EvaluationEngine und AI-Services. Keine kosmetischen Korrekturen – Fokus auf Struktur, Logik, Trennschärfe und Auswertbarkeit.

---

## Abschnitt 1: Ist-Analyse

### 1.1 Überblick Struktur und Belastung pro Screen

| Screen | Pflichtfelder | Optionale Felder | Eingabetypen | Kritische Probleme |
|--------|--------------|-----------------|-------------|-------------------|
| Phase 1: Situation & Vorlauf | 5 Textfelder + Kontext + Zeit = 7 Hauptelemente | 1 (Beteiligte) | Text ×4, Chips ×1, Grid ×1, Datum ×1 | Zu viele Elemente, konzeptuelle Vermischung |
| Phase 2: Körper & Gefühle | 3 Slider + Hauptgefühl | Zusatzgefühle, Körpersymptome | Slider ×3, Emotion-Grid, Chips | Body zweifach erhoben, Slider-Reihenfolge falsch |
| Phase 3: Gedanken & Verhalten | 5 Pflicht-Chips/Text | 3 optional | Text ×2, Chips ×5 | 8 Fragen, Überlappung Reaktion/Verhalten, zu klinisch |
| Phase 4: Einordnung | 5 Pflicht-Elemente | 3 optional | Chips ×4, Text ×3, Chips+Text ×2 | 9 Fragen, Redundanz zu Ph.1, Analysetiefe unrealistisch |

### 1.2 Inhaltliche Redundanz zwischen Screens

**Redundanzpaar 1: Problementstehung (gravierend)**
- Phase 1: „War das eigentliche Problem schon vorher da?" (Chips: Ja vorher / Teilweise / Erst in dem Moment / Weiß nicht)
- Phase 4: „War die Kleinigkeit nur der Trigger?" (Chips: Ja ziemlich sicher / Teilweise / Eher nicht / Weiß nicht)
→ Beide Fragen messen identisch dasselbe Konstrukt (Trigger-als-letzter-Tropfen). Eine davon ist vollständig redundant.

**Redundanzpaar 2: Vorlauf (inhaltlich überlappend)**
- Phase 1: „Womit war dein Kopf schon beschäftigt?" (Freitext, kognitiv)
- Phase 2: Vorbelastungs-Slider (0-10, skaliert)
→ Diese gehören zusammen, sind aber über zwei Screens aufgeteilt. Ein Nutzer in einem akuten Moment macht diese gedankliche Verbindung nicht zuverlässig.

**Redundanzpaar 3: Körperreaktion (konzeptuell doppelt)**
- Phase 2: Slider „Körperreaktion – wie angespannt warst du körperlich?" (0-10)
- Phase 2: „Was ist im Körper zuerst hochgegangen?" (Chips: Herzrasen, Druck, Hitze usw.)
→ Beide Fragen erheben Körperzustand, aber auf verschiedenen Abstraktionsniveaus. Auf demselben Screen wirkt das verwirrend und redundant. Nutzer fragen sich: Habe ich das nicht gerade schon beantwortet?

**Redundanzpaar 4: Hintergrundthema (zweifach erhoben)**
- Phase 4: Pflichtfeld „Was war das eigentliche Thema dahinter?" (Freitext)
- Datenmodell: `backgroundTheme` UND `touchedThemes` (Chips) UND `needOrWoundedPoint`
→ Drei verschiedene Felder für dasselbe semantische Gebiet: was tiefer liegt. In der Auswertungsengine werden alle drei genutzt, aber für den Nutzer fühlt sich die Dreifacherhebung wie Redundanz an.

### 1.3 Vermischung konzeptueller Ebenen

**Phase 1: Auslöser ≠ Ereignis**
Die Fragen „Was ist konkret passiert?" und „Was war der konkrete Auslöser?" sind konzeptuell zu ähnlich. Der Unterschied zwischen Situation/Ereignis und konkretem Trigger ist für die meisten Nutzer nicht intuitiv. Beide Felder landen im Datenmodell als `situationDescription` und `triggerDescription` – der Nutzen der Trennung zeigt sich erst in der AI-Analyse, nicht im Erfassungsmoment.

**Phase 3: Systemreaktion vs. tatsächliches Verhalten**
- „Wie hat dein System zuerst reagiert?" (Chips: Angreifen / Rückzug / Flucht / Erstarren / Beschwichtigen / Kontrollieren) → maps to `systemReaction`
- „Was hast du tatsächlich gemacht?" (Chips: laut geworden / geschrien / diskutiert usw.) → maps to `actualBehaviorTags`
→ Der Unterschied zwischen erster Reaktionsimpuls (innere Systemreaktion) und tatsächlichem Verhalten (nach außen sichtbar) ist psychologisch korrekt, aber für Laienpublikum ohne Erklärung schwer zu trennen. Die Optionen überlappen teilweise inhaltlich (Rückzug = Raum verlassen).

**Phase 2: Emotion und Leere**
`Leere` erscheint sowohl als Emotion (EmotionType.emptiness) als auch als Körpersymptom in den Body-Chips. Nutzer, die Leere fühlen, werden in beiden Listen darauf stoßen und müssen entscheiden, ob es ein Gefühl oder ein Körpersymptom ist – eine Unterscheidung, die klinisch relevant, aber alltäglich nicht sauber zu treffen ist.

### 1.4 Probleme in der Reihenfolge

**Slider vor Emotionswahl**
In Phase 2 kommen die drei Slider (Vorbelastung, Momentbelastung, Körperanspannung) VOR der Emotionsauswahl. Das ist didaktisch falsch: Nutzer können die Intensität ihrer Reaktion besser kalibrieren, wenn sie erst benennen, was sie gefühlt haben. Erst Emotion, dann Intensität ist die natürliche Reihenfolge des Empfindens.

**Erste Reaktion zu spät**
„Wie hat dein System zuerst reagiert?" steht in Phase 3 als viertes Element. Die erste Reaktion wäre logisch früher – direkt nach Emotion oder als Übergang von Phase 2 zu 3.

**Kipppunkt-Frage im falschen Kontext**
„Gab es einen Moment, an dem du kurz gemerkt hast, dass es kippt?" kommt nach Gedankenmustern und vor tatsächlichem Verhalten. Der Kipppunkt ist eine Meta-Reflexion über den ganzen Ablauf – er gehört eher ans Ende des Gedanken/Verhaltens-Blocks, nicht mittendrin.

**Alternative zu früh, Thema zu spät**
Phase 4 fragt nach dem „realistischen anderen Schritt" (Frage 3) bevor das Hintergrundthema benannt ist (Frage 6). Logischerweise braucht man das Verständnis des eigentlichen Themas, um sinnvolle Alternativen zu formulieren. Die Reihenfolge ist umgekehrt.

### 1.5 Kognitive und emotionale Belastung

**Kumulative Belastung nimmt zu statt ab**
Der Flow ist so aufgebaut, dass die analytisch anspruchsvollsten Screens (Phase 3 mit 8 Fragen, Phase 4 mit 9 Fragen) am Ende kommen. Nutzer, die den Flow nach einem belastenden Moment starten, sind zu diesem Zeitpunkt am erschöpftesten. Die Analysentiefe nimmt genau dann zu, wenn die Kapazität am geringsten ist.

**Phase 4 verlangt Einsicht, die Zeit braucht**
„Was war wahrscheinlich das eigentliche Thema dahinter?" ist ein Pflichtfeld, das echte Reflexionsfähigkeit voraussetzt. Viele Nutzer werden direkt nach einem Ereignis keine zuverlässige Antwort geben können – sie werden raten oder oberflächlich antworten. Das verschlechtert die Datenqualität, ohne es dem Nutzer zu signalisieren.

**Therapieterminologie ohne Erklärung**
Begriffe wie „automatischer Gedanke", „Systemreaktion", „Gedankenspirale", „Katastrophisieren", „Personalisieren" sind fachpsychologisch korrekt, aber nicht alltagssprachlich. Nutzer ohne Therapieerfahrung wissen möglicherweise nicht, was ein „automatischer Gedanke" ist und geben dann generische oder falsche Antworten. Das verringert die Auswertungsqualität.

**12 Lebensbereiche für Kontext-Auswahl**
12 Optionen im Grid sind grenzwertig viel. Einige überlappen konzeptuell (Alltag vs. Organisation/Haushalt vs. Finanzen). Für Schnellerfassung in einem akuten Moment ist 12 zu viele Entscheidungspunkte.

**17 Emotionen ohne Gruppierung**
17 Emotionen auf einem Screen, ohne visuelle Gruppierung nach Emotion-Familieren (Wut-Familie, Angst-Familie, Trauer-Familie), erhöht die Suchzeit und kognitive Last. Die Unterscheidung in Primary/Additional-Anzeige ist ein guter Ansatz, aber ohne Erklärung warum nicht selbst verständlich.

### 1.6 Interaktionsdesign-Probleme

**Choice-Chips mit Beschreibungstext**
Die Chips zeigen Beschreibungstext an, sobald eine Option selektiert ist. Das ist eine ungewöhnliche Interaktion, die Nutzer nicht antizipieren. Außerdem ist der Beschreibungstext bei manchen Optionen so formuliert, dass er das Verständnis einer Option voraussetzt, die erst im Nachhinein klar ist.

**Zwei Eingabetypen für denselben Zweck in Phase 4**
„Was wäre ein realistischer anderer Schritt?" und „Was ist der kleinste sinnvolle nächste Schritt?" haben beide Chip-Schnellauswahl + Freitextfeld. Das ist strukturell dasselbe Widget für zwei konzeptuell ähnliche Fragen. Nutzer werden fragen: Was ist der Unterschied zwischen diesen beiden?

**Read-Only Recap in Phase 4**
Die Rückschau auf Phase-3-Verhalten als Read-Only-Karte ist ein gutes UX-Pattern für Kontext. Aber sie funktioniert nur, wenn Phase 3 klare und lesbare Antworten geliefert hat. Wenn Nutzer in Phase 3 vage Chips gewählt haben, ist die Recap uninformativ.

**Datum/Zeit als letzter Punkt in Phase 1**
Zeitstempel ist wichtig für Musteranalyse, aber als letztes Element in Phase 1 oft nach dem wichtigen Inhalt erledigt. Bei Nachtrags-Erfassung (später erinnert) ist die Zeit oft unklar – eine explizite Warnung oder Hilfestellung fehlt.

### 1.7 Datenqualitätsprobleme für Auswertung

**Unscharfe Freitexte landen in der AI**
Felder wie `situationDescription`, `automaticThought`, `backgroundTheme` werden an den AI-Dienst übergeben. Wenn Nutzer vage oder unpräzise antworten (was bei hohem kognitivem Aufwand wahrscheinlich ist), liefert die AI schwächere Einordnungen. Es gibt keine Eingabequalitätsprüfung oder Guidance, die auf Präzision hinwirkt.

**Drei Felder für dasselbe semantische Konzept**
`touchedThemes` (Chips), `needOrWoundedPoint` (wird aus touchedThemes gebildet), `backgroundTheme` (Freitext) überlappen semantisch. Die EvaluationEngine nutzt alle drei, aber für Musteranalyse und AI-Reflexion werden alle drei separat verarbeitet – was bei inkonsistenter Nutzerbefüllung zu inkonsistenten Auswertungen führt.

**Fehlende Ebene: zeitlicher Abstand zur Situation**
Es gibt kein Feld für „Wann erfasst du das, verglichen mit wann es passiert ist?" Ein Nutzer, der 3 Stunden später erfasst, liefert andere (reguliertere) Antworten als jemand im Moment. Das beeinflusst alle Intensitätswerte, aber es gibt keine Möglichkeit, das in der Auswertung zu gewichten.

---

## Abschnitt 2: Designprinzipien für die Überarbeitung

### P1 – Eine konzeptuelle Ebene pro Screen
Jeder Screen erfasst genau eine klar definierte Ebene der Situation: Ereignis/Kontext, Körper/Intensität, Gefühl, Reaktion/Verhalten, Einordnung. Keine Vermischung von äußerem Geschehen und innerer Bewertung auf demselben Screen.

### P2 – Chronologische Dramaturgie der Wahrnehmung
Die Screenreihenfolge folgt der natürlichen Abfolge des Erlebens: Was ist passiert → Was spürte ich körperlich → Was fühlte ich → Wie reagierte ich → Was steckt dahinter. Keine analytischen Tieffragen bevor das Grundlegende erfasst ist.

### P3 – Intensität vor Interpretation
Intensive, skalierbare Informationen (Körperspannung, Intensität) kommen NACH der qualitativen Benennung (Emotion, Reaktion), nicht davor. Erst benennen, dann bewerten.

### P4 – Redundanz eliminieren, nicht kaschieren
Kein Konstrukt wird zweifach erhoben. Wenn dieselbe Frage auf zwei verschiedene Weisen auftaucht, ist eine davon zu streichen oder in eine nachgelagerte optionale Reflexion zu verschieben.

### P5 – Pflicht/Optional-Trennung nach Auswertungsrelevanz
Pflichtfelder sind nur jene, die für die regelbasierte Auswertungsengine zwingend notwendig sind. Alle interpretationsreichen Einordnungsfelder (Hintergrundthema, Muster, Alternative) sind optional im Ersterfassungsflow und können im Reflexionsmodus nachgeholt werden.

### P6 – Alltagssprache statt Fachterminologie
Psychologische Fachbegriffe (automatischer Gedanke, Systemreaktion, Katastrophisieren) werden entweder vermieden, paraphrasiert oder mit einem kurzen, alltagsnahen Beispiel eingeführt. Kein Begriff, den ein Laie beim ersten Lesen nicht versteht.

### P7 – Abnehmende Erfassungstiefe bei zunehmender Belastung
Ein Belastungssignal (hohe Intensität, akute Aktivierung, Crisis-Flag) löst automatisch eine vereinfachte Flow-Variante aus. Nutzer in akuten Momenten werden in den Kern-Flow geführt, nicht durch den vollen 4-Phasen-Prozess.

### P8 – Analytische Tiefe in die Nachreflexion auslagern
Alles, was echte Reflexionsdistanz braucht (Hintergrundthema, Muster-Erkennung, Alternativenformulierung), gehört in den optionalen Nachreflexionsbereich (AI-Modes, Interventionsscreens), nicht in den Ersterfassungsflow als Pflicht.

### P9 – Strukturell-valide Eingaben statt offene Texte für Auswertungsfelder
Felder, die direkt in die Regel-Engine oder AI fließen, sollen primär über strukturierte Auswahl (Chips, Single-Select) erfasst werden, nicht als Freitext. Freitext ist wertvoll für Kontextualisierung, aber schlechte Basis für algorithmische Auswertung.

### P10 – Eingabe-Qualität durch Kontext-Scaffolding
Kurze, konkrete Beispiele in Hilfetexten bleiben, aber die Fragen selbst werden so formuliert, dass sie die Art der Antwort bereits kanalisieren (Was genau gesagt/getan, nicht was du gefühlt hast auf diesem Screen).

### P11 – Adaptive Flow-Länge
Der Flow erkennt anhand früher Signale (Intensität, System-Reaktion), ob ein Nutzer gerade in der Lage ist, alle Phasen zu durchlaufen. Ein verkürzter „Stabilisierungsflow" endet nach Phase 2 und delegiert Analyse explizit an die spätere Reflexion.

### P12 – Keine konzeptuelle Überlappung zwischen Pflichtfeldern
Jedes Pflichtfeld erfasst ein einzigartiges Konstrukt, das durch kein anderes Pflichtfeld abgedeckt wird. Wenn zwei Felder semantisch ähnlich sind, ist eines optional oder wird eliminiert.

---

## Abschnitt 3: Verbesserungsplan

### 3.1 Phase 1: Aufteilen und entschärfen

**Problem:** 7 Hauptelemente, konzeptuelle Vermischung von Ereignis und Vorlauf.

**Plan:**
- Phase 1 in zwei konzeptuell saubere Sub-Screens aufteilen:
  - **1a – Ereignis und Kontext:** Was ist passiert (Pflicht, kurz), Kontext/Lebensbereich, Zeitstempel, optional Beteiligte
  - **1b – Vorlauf und Auslöser:** Was war schon vorher (Vorbelastung kognitiv, Pflicht), Was war der konkrete Auslöser (Pflicht, kurz), Vorbelastungs-Slider (von Phase 2 hierher)
- Die Frage „War das eigentliche Problem schon vorher da?" aus Phase 1 streichen – sie wird durch Phase 4 redundant erfasst (eine der beiden ist zu eliminieren)
- Die Trennung zwischen „Was ist passiert" und „Konkreter Auslöser" vereinfachen: Entweder zu einem Feld zusammenführen oder klarer als Ereignis (Situation gesamt) vs. Trigger (der Moment, der es ausgelöst hat) differenzieren – mit kurzem Scaffold-Beispiel in der Frage

### 3.2 Phase 2: Reihenfolge korrigieren, Doppelerhebung bereinigen

**Problem:** Slider vor Emotionswahl, Körper doppelt erhoben, 17 Emotionen ungeclustert.

**Plan:**
- Reihenfolge umkehren: 1. Emotionswahl → 2. Intensitäts-Slider (Momentbelastung) → 3. Körperanspannungs-Slider → 4. Körpersymptome (Chips, optional)
- Die drei Slider auf zwei reduzieren: Vorbelastungs-Slider nach Phase 1b verschieben, nur Momentintensität und Körperanspannung in Phase 2 behalten
- Emotionen in visuelle Gruppen clustern (z.B. Wut-Familie, Angst-Familie, Trauer-Scham-Schuld-Familie, Ohnmacht-Überforderung) – hilft Nutzern schneller zu navigieren
- `Leere` entweder nur als Emotion oder nur als Körpersymptom behandeln, nicht beides
- Positive Emotionen (Freude, Stolz) visuell separieren oder in einen optionalen „auch dabei"-Bereich verschieben, da sie in der Erfassung einer belastenden Situation selten primär sind

### 3.3 Phase 3: Trennung schärfen, Komplexität reduzieren

**Problem:** 8 Fragen, unscharfe Trennung Systemreaktion/Verhalten, zu klinische Begriffe.

**Plan:**
- Screen in zwei logische Blöcke gliedern (nicht unbedingt zwei Screens, aber visuelle Trennung):
  - **Block A – Gedanken:** Gedankenfokus (was war schon im Kopf) + erster automatischer Gedanke + Fakt-Deutung-Einschätzung
  - **Block B – Verhalten:** Erste Reaktion/Impuls + tatsächliches Verhalten + Kipppunkt-Erkenntnis
- „Gedankenmuster" (Grübeln, Katastrophisieren usw.) aus dem Pflichtbereich in den optionalen Bereich verschieben oder in die AI-Reflexion delegieren
- Terminologie überarbeiten: „Wie hat dein System zuerst reagiert?" → klarer in Alltagssprache umformulieren (ohne den Begriff „System")
- Die Frage „Was hat dir am meisten Angst gemacht?" (optional) streichen oder nach Phase 4 verschieben – sie ist eine Einordnungsfrage, keine Verhaltensfrage
- Kipppunkt-Frage ans Ende des Screens verschieben (nach Verhalten) – sie ist eine Metareflexion über den ganzen Ablauf

### 3.4 Phase 4: Tiefe in Reflexion auslagern

**Problem:** 9 Fragen, Redundanz zu Phase 1, Analysetiefe für akuten Moment zu hoch.

**Plan:**
- Phase 4 auf das absolute Minimum für Auswertung reduzieren:
  - **Pflicht (3-4 Felder):** Betroffenes Thema/Bedürfnis (Chips, aus heutigen `touchedThemes` + `neededSupports` zusammenführen), nächster realistischer Schritt (Chips + optional Text), „Trigger als letzter Tropfen?" (eine der beiden redundanten Fragen, entweder hier oder in Phase 1)
  - **Optional im Sofortflow:** Hintergrundthema (Freitext), Entschärfungsalternative, Mustererkennung
- „Kennst du dieses Muster von früher?" vollständig in den AI-Reflexionsmodus auslagern – das ist eine klassische Reflexionsfrage, keine Ersterfassungsfrage
- „Was hättest du eigentlich gebraucht?" und „Was wurde in dir getroffen?" auf einem Screen zusammenführen, da sie dasselbe semantische Gebiet (Bedürfnis/Verletzung) abdecken
- Die Read-Only-Verhaltensrecap behalten, aber optional ausblendbar machen
- Das freie Freitextfeld „Was war das eigentliche Thema?" von Pflicht auf stark empfohlen/optional setzen – die AI kann das ableiten, wenn Chips ausgefüllt sind

### 3.5 Adaptiver Kurzflow bei hoher Belastung

**Problem:** Bei akuter Aktivierung (Intensity ≥ 8 oder SystemState = acuteActivation/crisis) ist der volle 4-Phasen-Flow überfordernd.

**Plan:**
- Nach Phase 2 prüfen: Wenn Intensität ≥ 8 UND/ODER Körperanspannung ≥ 7:
  - Nutzer aktiv anbieten: „Das klingt gerade sehr intensiv. Soll ich dir jetzt erst eine kurze Stabilisierungsübung zeigen statt dem vollen Protokoll?"
  - Kurzflow: Phase 1 + 2 + minimale Phase 3 (nur Reaktion + Verhalten) → direkt zu Stabilisierungsintervention → Reflexion als späteren optionalen Schritt anbieten
- Der Stabilisierungsmodus der AI-Reflexion sollte früher erreichbar sein, nicht erst nach vollem Durchlauf

### 3.6 Kontext-Selektion vereinfachen

**Problem:** 12 Lebensbereiche, teilweise überlappend.

**Plan:**
- Lebensbereiche auf 7-8 klar getrennte Kategorien reduzieren:
  - Arbeit / Familie / Partnerschaft / Freunde & Soziales / Körper & Gesundheit / Innen (Selbst/Leistung/Einsamkeit) / Alltag & Organisation / Sonstiges
- Finanzen, Freizeit, Alleinsein in übergeordnete Kategorien integrieren statt eigene Einträge

### 3.7 Interaktionsmuster überprüfen

- **Sliders:** 3 Slider hintereinander sind monoton – mindestens optisch trennen oder zeitlich staffeln (nicht alle auf einmal zeigen)
- **Chip-Beschreibungen:** Beschreibungstext bei Chip-Selektion ist unintuitiv – Alternative: Beschreibungstext permanent unter dem Chip-Label anzeigen (kleiner), nicht erst bei Selektion
- **Zwei Chips+Text-Felder in Phase 4:** Strukturell unterscheiden (z.B. eines als Chip-only, eines als Text-only) um Verwechslung zu vermeiden
- **Max-2-Hinweis bei Chips:** Der Hinweis „max. 2" erscheint teils erst im Helper-Text, nicht prominent vor der Auswahl – sollte in den Chip-Header

---

## Abschnitt 4: Priorisierung

### Hebel 1 (Sofort, größte Wirkung): Redundanz zwischen Phase 1 und Phase 4 beheben

**Was:** Die Frage „War das eigentliche Problem schon vorher da?" (Phase 1) oder „War die Kleinigkeit nur der Trigger?" (Phase 4) streichen – eine davon bleibt, eine fällt weg.

**Warum zuerst:** Diese Doppelerhebung führt zu inkonsistenten Daten in `problemTiming` und `triggerAsLastDrop`, verschlechtert die EvaluationEngine-Qualität und irritiert Nutzer, die merken, dass sie dasselbe zweimal gefragt werden. Außerdem ist es die kleinste Änderung mit größtem Bereinigungseffekt.

**Risiko beim falschen Umbau:** Wenn beide Felder beibehalten aber zusammengeführt werden (statt eines zu streichen), entsteht ein komplexeres Widget ohne Mehrwert.

### Hebel 2 (Sofort): Slider-Reihenfolge in Phase 2 umkehren

**Was:** Emotion auswählen bevor Intensität bewertet wird.

**Warum zuerst:** Kleiner Eingriff, klarer psychologischer Grund, direkte Qualitätsverbesserung der Intensitätsdaten. Daten sind derzeit in falscher Reihenfolge kalibriert.

### Hebel 3 (Kurzfristig, hohe Wirkung): Phase 4 auf Kernfelder reduzieren

**Was:** Phase 4 von 9 auf 4-5 Elemente reduzieren. Tiefe Einordnungsfelder in optionalen Bereich / AI-Reflexion auslagern.

**Warum:** Phase 4 ist der häufigste Abbruchpunkt bei langen Flows. Nutzer, die den Flow nach einem belastenden Moment starten, haben am Ende die geringste kognitive Kapazität. Zu viele Pflichtfelder in Phase 4 erzeugen entweder Abbruch oder minderwertige Antworten.

**Risiko:** Die EvaluationEngine ist auf bestimmte Felder angewiesen (`touchedThemes`, `neededSupports`, `backgroundTheme`). Bei Auslagerung in optional müssen die Engine-Regeln Fallbacks für fehlende Daten haben. Prüfen, welche Felder für Minimum-viable-Evaluation zwingend sind.

### Hebel 4 (Kurzfristig): Terminologie alltagstauglich machen

**Was:** „Automatischer Gedanke", „Systemreaktion" und Gedankenmuster-Begriffe paraphrasieren oder mit Beispielen einführen.

**Warum:** Schlechte Dateneingabe durch Unverständnis ist nicht messbar, weil alles formal gültig aussieht. Fehlgeleitete Antworten bei verstandenen Fragen sind seltener als fehlgeleitete bei unverstandenen – und das Muster zeigt sich erst in AI-Reflexionsqualität und Musterdaten.

### Hebel 5 (Mittelfristig): Adaptiver Kurzflow bei Hochbelastung

**Was:** Nach Phase 2 Intensitätssignal auswerten, alternativen Flow-Pfad anbieten.

**Warum:** Nutzer in akuten Momenten brauchen Stabilisierung, keine Analyse. Aktuell bekommen sie denselben Flow wie Nutzer, die später in Ruhe reflektieren. Das ist klinisch und UX-technisch falsch.

**Risiko:** Komplexere Flow-Logik, mehr States, Testaufwand höher. Mittel priorisiert, weil die Implementierung non-trivial ist.

### Hebel 6 (Mittelfristig): Phase 1 aufteilen, Vorlauf-Slider integrieren

**Was:** Phase 1 in 1a (Ereignis/Kontext) und 1b (Vorlauf/Auslöser + Vorbelastungs-Slider) aufteilen.

**Warum:** Phase 1 ist aktuell zu voll. Die Aufteilung schärft die konzeptuelle Trennung und verteilt kognitive Last besser.

**Risiko:** Aus 4 wird 5 Screens (wahrgenommene Länge des Flows steigt). Müsste durch sichtbare Vereinfachung an anderer Stelle kompensiert werden.

### Feinschliff (Nachrangig)

- Emotionen in visuelle Cluster gruppieren
- `Leere` als Kategorie-Zuweisung klären (Emotion oder Körpersymptom)
- Kontext-Grid auf 8 Optionen reduzieren
- Chip-Beschreibungstext dauerhaft sichtbar statt nur bei Selektion
- Positive Emotionen visuell separieren

### Risikozonen beim falschen Umbau

- **EvaluationEngine-Eingaben nicht brechen:** Wenn Felder aus dem Pflicht-Flow in Optional verschoben werden, braucht die Engine für alle betroffenen Felder saubere Nullhandlung. Fehlende Daten dürfen kein falsches SystemState produzieren.
- **AI-Codec-Felder prüfen:** Der AI-Request-Codec verwendet Feld-Längen und spezifische Keys. Umbenennungen oder Merges von Feldern müssen dort synchron angepasst werden.
- **Datenbankschema ist versioniert (v4):** Schemaänderungen erfordern Migration. Feldumbenennungen oder -entfernungen sind risikobehaftet bei bestehenden Einträgen.

---

## Kritische Dateien

- `lib/features/new_situation/screens/situation_event_screen.dart` – Phase 1
- `lib/features/new_situation/screens/situation_emotion_screen.dart` – Phase 2
- `lib/features/new_situation/screens/situation_thought_impulse_screen.dart` – Phase 3
- `lib/features/new_situation/screens/situation_reflection_screen.dart` – Phase 4
- `lib/application/providers/new_situation_providers.dart` – Flow-State und Validation
- `lib/domain/models/evaluation.dart` + Freezed models – Datenmodell
- `lib/domain/services/evaluation_engine.dart` – Regelengine (abhängig von Feldern)
- `lib/data/db/app_database.dart` – Datenbankschema (v4, Migration bei Änderungen)
- `lib/data/services/ai_reflection_request_codec.dart` – AI-Payload (synchron halten)
- `assets/content/evaluation_copy.de.json` – Evaluation-Content-Keys

## Verifikation nach Umbau

1. Vollständiger Flow-Durchlauf (alle 4 Phasen) mit validen Daten
2. `flutter test test/unit/evaluation_engine_test.dart` – Evaluation-Engine-Korrektheit
3. `flutter test test/features/evaluation/entry_evaluation_screen_test.dart` – Auswertungsscreen
4. Manuell prüfen: AI-Reflexion-Request-Codec mit umgebauten Feldern (Feldnamen, Längen)
5. Datenbankschema-Migration testen wenn Felder entfernt/umbenannt werden
