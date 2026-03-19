---
title: "Rechteklärung und Lizenzmatrix — Innenkompass"
document_type: "legal-rights-analysis"
project: "Innenkompass"
version: "1.0"
status: "aktiv"
date_created: "2026-03-16"
last_updated: "2026-03-19"
language: "de"
audience:
  - "Produktplanung"
  - "Entwicklung"
  - "Rechtliches Review"
purpose: "Übersicht der Urheberrechts- und Lizenzlage für alle verwendeten oder geplanten Therapiematerialien. Entscheidungsgrundlage für MVP-Templates."
disclaimer: "Kein Rechtsgutachten. Dient der internen Planung. Für private Nutzung sind viele Anforderungen reduziert. Vor öffentlicher oder breiter externer Verbreitung juristisches Review empfohlen."
---

# Rechteklärung und Lizenzmatrix — Innenkompass

> **Hinweis:** Dieses Dokument ist kein Rechtsgutachten. Es fasst den Recherche- und Planungsstand zusammen.

> **Für private Nutzung:** Bei reinem Eigengebrauch ohne Weitergabe an Dritte sind viele lizenzrechtliche Anforderungen reduziert. Konzepte und Ideen sind nicht urheberrechtlich geschützt – nur deren konkrete Ausgestaltung (Wortlaut, Layout, 1:1-Kopien). Dieses Dokument wird relevant bei:
> - Weitergabe der App an Dritte (auch kostenlos)
> - Kommerzieller Nutzung
> - Öffentlicher oder breiter externer Verbreitung

---

## 1. Überblick: Materialquellen und ihre Rechtelage

### 1.1 IBT / Individualisierte Burnout-Therapie (Kohlhammer)

| Merkmal | Details |
|---|---|
| **Vollständiger Titel** | Individualisierte Burnout-Therapie (IBT) |
| **Autor** | Gert Kowarowsky |
| **Verlag** | W. Kohlhammer GmbH, Stuttgart |
| **Auflage** | 1. Auflage 2017 |
| **Inhalt** | Multimodaler Ansatz (KVT + REVT/REBT + Motivational Interviewing); Modul 3 enthält ABC-Modell und Rationale Selbstanalyse (RSA) |
| **Urheberrecht** | Klassische Verlagsklausel: Verbot der Vervielfältigung und elektronischen Verarbeitung ohne Zustimmung |
| **Downloadmaterialien** | Zusatzmaterial im Downloadbereich: „urheberrechtlich geschützt, nur persönlicher, nicht-gewerblicher Gebrauch" |
| **Risiko 1:1-Digitalisierung** | Hoch — explizites Verbot der elektronischen Verarbeitung ohne Zustimmung |

**Konsequenz für Innenkompass:**
- Keine 1:1-Kopie von Texten, Layouts oder Arbeitsblättern aus IBT
- Feldlogik (ABC-Modell, RSA-Struktur) kann eigenständig implementiert werden — Konzepte sind nicht urheberrechtlich geschützt
- Bei Lizenzierungs-Ambition: Kontakt zu W. Kohlhammer GmbH, Abteilung Foreign Rights & Licensing

---

### 1.2 UP / Unified Protocol Arbeitsbuch (Hogrefe)

| Merkmal | Details |
|---|---|
| **Vollständiger Titel** | Transdiagnostische Behandlung emotionaler Störungen — Arbeitsbuch |
| **Autoren** | David H. Barlow et al. |
| **Herausgeber (deutsch)** | Franz Caspar |
| **Verlag (deutsch)** | Hogrefe Verlag GmbH & Co. KG |
| **ISBN** | 978-3-456-85241-6 (1. Aufl. 2019) |
| **Inhalt** | Selbsttests, Übungsblätter für emotionale Störungen; transdiagnostisch |
| **Originalrechte** | Oxford University Press (OUP) für die englische Originalversion |
| **Download-Arbeitsblätter** | Hogrefe stellt einzelne Blätter als Download bereit — mit Copyright-Hinweis auf das Arbeitsbuch |
| **Risiko Repackaging** | Hoch — Copyright-Vermerk explizit vorhanden |
| **Permissions-Kontakt** | Hogrefe betreibt Rights & Permissions-Seite mit Lizenzabteilung |

**Konsequenz für Innenkompass:**
- Keine 1:1-Übernahme von Hogrefe-Arbeitsblättern
- Feldlogik und therapeutische Konzepte können eigenständig formuliert werden
- Für lizenzierte Integration: Anfrage an Hogrefe Permissions (permissions@hogrefe.de oder über Rights & Permissions-Seite)

---

### 1.3 ODSIS / Overall Depression Severity and Impairment Scale (OUP)

| Merkmal | Details |
|---|---|
| **Vollständiger Name** | Overall Depression Severity and Impairment Scale (ODSIS) |
| **Kontext** | Bestandteil des Unified Protocol (UP)-Materialkatalogs |
| **Rechteinhaber** | Oxford University Press (OUP) |
| **Struktur** | 5 Items, Rückblick „letzte Woche", Ratings 0–4; Summe 0–20 |
| **Bereiche** | Häufigkeit, Intensität, Beeinträchtigung von Aktivitäten, Arbeit/Schule/Haushalt, soziale Beziehungen |
| **Deutsche Übersetzung** | Zusätzliche Rechte bei Hogrefe (deutsche Ausgabe) |
| **Freie Nutzung** | Nicht gefunden / nicht eindeutig spezifiziert für App-Kontext |
| **Risiko** | App-Implementierung ohne Lizenz riskant; OUP-Copyright-Vermerk vorhanden |

**Konsequenz für Innenkompass:**
- **MVP ohne ODSIS**: Eigenentwickelte `SelbsteinschätzungsSkala` in eigenen Worten (→ Abschnitt 3)
- ODSIS als „späterer, lizenzierter Ersatz" einplanen — wenn Rechte mit OUP und Hogrefe geklärt

---

## 2. Lizenz-Tag-System für Templates

Jedes Template in der App bekommt einen `license_tag`, der den Rechtestatus dokumentiert.

### 2.1 Definierte License-Tags

| Tag | Bedeutung | Verwendung |
|---|---|---|
| `original-inspired-no-copy` | Eigenentwicklung, inhaltlich an etablierten Modellen orientiert, kein Wortlaut aus geschütztem Material | Standard für MVP-Templates |
| `license-required` | Template ist ohne Verlagsgenehmigung nicht verwendbar — nur Platzhalter | Für spätere lizenzierte Inhalte |
| `licensed-kohlhammer` | Nach Rechteklärung mit W. Kohlhammer GmbH freigegeben | Erst nach schriftlicher Zustimmung |
| `licensed-hogrefe` | Nach Rechteklärung mit Hogrefe freigegeben | Erst nach schriftlicher Zustimmung |
| `licensed-oup` | Nach Rechteklärung mit Oxford University Press freigegeben | Erst nach schriftlicher Zustimmung |
| `public-domain` | Frei verwendbar, kein Copyright | Für eigene vollständige Entwicklungen |

### 2.2 Technische Umsetzung

Im aktuellen Repo wird der `license_tag` leichtgewichtig als eigenes Feld `licenseTag` im `Intervention`-Modell geführt. Ergänzend kann `licenseNotes` den Herkunftshinweis aufnehmen:

```dart
Intervention(
  // ...
  licenseTag: ContentLicenseTag.originalInspiredNoCopy,
  licenseNotes:
      'Feldlogik nach CBT/REBT-Konzept; eigene Formulierungen',
)
```

Im späteren Template-Registry-Konzept wird `license_tag` ein Pflichtfeld auf `WorksheetTemplate`.

---

## 3. Eigenentwickelte Alternativen

### 3.1 ABC-3 Kurzprotokoll — Eigenentwicklung

**Feldlogik:** Das ABC-Modell (Auslöser → Bewertung → Konsequenzen) ist ein psychologisches Konzept aus dem CBT/REBT-Bereich und urheberrechtlich nicht schützbar. Die **konkrete Umsetzung** (Wortlaut, Layout, Formulierung der Fragen) muss eigenständig sein.

**MVP-Umsetzung:**
- Eigene Feldnamen: `situation.description`, `beliefs[]`, `consequence.emotions[]`, `consequence.body_signals[]`, `consequence.behavior`
- Eigene Frageformulierungen (keine 1:1-Kopie von IBT-Arbeitsblättern)
- `license_tag`: `original-inspired-no-copy`

---

### 3.2 RSA/ABCDE — Eigenentwicklung

**Feldlogik:** Die Erweiterung ABC → ABCDE (Disputation + Effective New Response) ist im REBT-Kontext etabliert und nicht proprietär. Ellis' ABCDE-Modell ist Allgemeingut.

**MVP-Umsetzung:**
- Eigene D-Fragen: „Entspricht dieser Gedanke überprüfbaren Fakten?" und „Ist dieser Gedanke hilfreich für mich?"
- Eigene E-Felder: rationale Alternative + Wunschverhalten
- `license_tag`: `original-inspired-no-copy`

---

### 3.3 SelbsteinschätzungsSkala — Eigenentwicklung (statt ODSIS)

**Hintergrund:** ODSIS ist urheberrechtlich geschützt (OUP). Für MVP wird eine eigenentwickelte Kurzskala mit eigenen Itemformulierungen erstellt.

**Eigenentwickelte Items (eigene Formulierungen):**

| # | Bereich | Eigene Formulierung | Skala |
|---|---|---|---|
| 1 | Häufigkeit | „Wie oft haben Sie sich in der letzten Woche gedrückt, niedergeschlagen oder leer gefühlt?" | 0 = Nie / 4 = Fast immer |
| 2 | Intensität | „Wie stark war diese Belastung, wenn sie aufgetreten ist?" | 0 = Gar nicht / 4 = Extrem stark |
| 3 | Aktivitäten | „Wie sehr hat die Belastung Ihr Interesse oder Ihre Freude an Dingen beeinträchtigt, die Ihnen normalerweise wichtig sind?" | 0 = Keine Einschränkung / 4 = Völlig eingeschränkt |
| 4 | Aufgaben | „Wie sehr hat die Belastung Ihre Fähigkeit beeinträchtigt, alltägliche Aufgaben (Arbeit, Haushalt, Schule) zu erledigen?" | 0 = Keine Einschränkung / 4 = Völlig eingeschränkt |
| 5 | Soziales | „Wie sehr hat die Belastung Ihre sozialen Kontakte und Beziehungen eingeschränkt?" | 0 = Keine Einschränkung / 4 = Völlig eingeschränkt |

**Gesamtpunkte:** 0–20 (Summe)
**Interpretation:** Nur Verlauf anzeigen — kein Diagnose-Label, kein Grenzwert-Cutoff im MVP

**`license_tag`:** `public-domain` (vollständige Eigenentwicklung)

**Wichtig:** Diese Skala erhebt keinen Anspruch, ODSIS zu ersetzen oder die diagnostische Güte von ODSIS zu erreichen. Sie ist ein eigenständiges, pragmatisches Selbstbeobachtungs-Werkzeug.

---

## 4. Kontaktpfade für Rechteklärung

### 4.1 W. Kohlhammer GmbH (IBT)

| Kontaktweg | Details |
|---|---|
| **Webseite** | kohlhammer.de |
| **Relevante Abteilung** | Foreign Rights & Licensing |
| **Anfrageinhalt** | Digitale Nutzung des ABC-Modells und der RSA-Arbeitsblatt-Feldlogik als App; Nutzungsumfang: App-Store, ggf. kommerziell |
| **Erwartete Fragen seitens Verlag** | Nutzungsumfang (kostenlos/kostenpflichtig?), Zielgruppe, Vertriebsgebiet |

### 4.2 Hogrefe Verlag GmbH & Co. KG (UP-Arbeitsblätter)

| Kontaktweg | Details |
|---|---|
| **Webseite** | hogrefe.de |
| **Rights & Permissions** | permissions@hogrefe.de (oder über Website) |
| **Anfrageinhalt** | Digitale Arbeitsblatt-Implementierung basierend auf UP-Konzepten; eigene Formulierungen vs. Originaltexte |
| **Hinweis** | Hogrefe hat eine explizite Rights & Permissions-Abteilung |

### 4.3 Oxford University Press (ODSIS/OUP)

| Kontaktweg | Details |
|---|---|
| **Webseite** | academic.oup.com |
| **Rights-Kontakt** | permissions@oup.com |
| **Anfrageinhalt** | Lizenz für ODSIS-Implementierung in digitaler Anwendung; App-Store-Vertrieb |
| **Hinweis** | Deutsche Übersetzung hat zusätzliche Hogrefe-Rechte — beide müssen angefragt werden |

---

## 5. Regulatorische Abgrenzung

### 5.1 Kein Medizinprodukt / kein DiGA im MVP

Solange die App keine medizinische Zweckbestimmung hat, ist sie kein Medizinprodukt (MDR) und muss nicht als DiGA (Digitale Gesundheitsanwendung) zugelassen werden.

**Für private Nutzung:** Bei reinem Eigengebrauch ohne öffentliche Verbreitung sind regulatorische Anforderungen deutlich reduziert. Die folgenden Hinweise werden relevant bei geplanter Weitergabe oder anderer externer Verbreitung.

**Safe-Harbor-Positionierung:**
> „Digitale Arbeitsblatt-Bibliothek für Selbstreflexion und kognitive Umstrukturierung — kein Therapieersatz, kein Notfall-Dienst"

**Verbotene Claims im Marketing** (relevant bei externer oder öffentlicher Verbreitung):
- „Behandelt Burnout"
- „Therapiert Depression"
- „Medizinisch validiert"
- „Ersetzt psychotherapeutische Behandlung"

**Erlaubte Claims:**
- „Unterstützt Selbstreflexion"
- „Strukturierte Gedankenprüfung"
- „Eigenverantwortliche Stressbewältigung"

### 5.2 DSGVO Art. 9 — Besondere Kategorien von Gesundheitsdaten

Emotionale Zustände und Belastungswerte gelten als Gesundheitsdaten nach DSGVO Art. 9.

**Für private Nutzung:** Bei reinem Eigengebrauch ohne kommerzielle Verarbeitung sind viele DSGVO-Anforderungen reduziert (Haushaltsausnahme, Art. 2 Abs. 2 lit. c DSGVO). Dennoch sind die folgenden Prinzipien gute Praxis:

- Lokal-first (kein Cloud-Sync ohne explizite Zustimmung)
- Datenlöschung muss möglich sein
- Kein automatischer Export
- App-Lock optional anbieten

**Bei externer Weitergabe:** DSGVO voll anwendbar → ausdrückliche Einwilligung bei Erststart erforderlich.

### 5.3 DiGA-Pfad (optional, später)

Falls DiGA angestrebt wird:
1. CE-Kennzeichnung als Medizinprodukt (Klasse I oder IIa) erforderlich
2. Evidenz: Pilotstudie → RCT/vergleichende Studie gemäß BfArM-Leitfaden
3. QMS/ISMS-Zertifizierung
4. Datenschutz-Konzept nach DiGAV
5. BfArM-Bewertungszeit: ca. 3 Monate nach vollständigem Antrag

**Empfehlung:** DiGA-Pfad erst nach erfolgreichem Product-Market-Fit einschlagen. Für private Nutzung irrelevant.

---

## 6. Risikomatrix

| Risiko | Wahrscheinlichkeit | Schwere | Mitigation |
|---|---|---|---|
| Urheberrechtsverletzung (IBT) | Niedrig (bei eigenen Formulierungen) | Hoch | Keine 1:1-Kopie; eigene Formulierungen |
| Urheberrechtsverletzung (Hogrefe/UP) | Niedrig (bei eigenen Formulierungen) | Hoch | Keine 1:1-Kopie; Lizenz anfragen |
| ODSIS ohne Lizenz verwenden | Hoch (wenn 1:1 kopiert) | Hoch | Eigenentwickelte SelbsteinschätzungsSkala nutzen |
| „Krankheits-Claims" → Medizinprodukt-Pflicht | Niedrig (bei korrekter Positionierung) | Sehr hoch | Positionierung als Selbstreflexions-Tool; kein medizinisches Wording |
| DSGVO Art. 9 Verstoss | Niedrig (local-first, private Nutzung) | Sehr hoch | Local-first Architektur; Haushaltsausnahme nutzbar |
| DiGA-Pflicht bei Marktzugang | Niedrig im MVP | Hoch | Keine Heilsversprechen; Wellness-Positionierung |

**Hinweis zur privaten Nutzung:** Bei reinem Eigengebrauch ohne Weitergabe sind die Risiken deutlich reduziert. Die Tabelle wird relevant bei geplanter externer Weitergabe oder einem späteren öffentlichen Vertriebspfad.

---

## 7. Nächste Schritte (Rechteklärung)

| # | Aufgabe | Priorität | Status |
|---|---|---|---|
| 7.1 | Rechte-Matrix: vollständige Liste aller geplanten Templates + Quelle + Rechtestatus | Prio 1 | ✓ In diesem Dokument |
| 7.2 | Kontaktaufnahme Hogrefe (Rights & Permissions) | Prio 3 | offen (nur bei späterer externer oder öffentlicher Weitergabe) |
| 7.3 | Kontaktaufnahme Kohlhammer (Licensing) | Prio 3 | offen (nur bei späterer externer oder öffentlicher Weitergabe) |
| 7.4 | ODSIS-Lizenz klären (OUP + Hogrefe) — für spätere Version | Prio 3 | offen (nur bei späterer externer oder öffentlicher Weitergabe) |
| 7.5 | MVP ohne lizenzpflichtige Skalen finalisieren | Prio 1 | ✓ SelbsteinschätzungsSkala implementiert |
| 7.6 | Juristisches Review vor öffentlicher/externer Verbreitung | Pflicht (falls geplant) | offen |
| 7.7 | DSGVO-Einwilligungstext für Erststart formulieren | Prio 2 | offen |

**Hinweis:** Die Aufgaben 7.2–7.4 und 7.6 sind nur bei geplanter externer Weitergabe relevant. Für reine private Nutzung können diese Schritte entfallen.
