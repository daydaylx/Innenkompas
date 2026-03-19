# Innenkompass – Datenschutzhinweis für private Nutzung

> **Hinweis:** Dieses Dokument ist als Vorlage für die **private Nutzung** gedacht. Bei reinem Eigengebrauch sind viele formale Anforderungen reduziert. Bei Weitergabe an Dritte (auch kostenlos) sollten die Hinweise geprüft und angepasst werden.

---

## Verantwortlicher (für private Nutzung optional)

Bei reiner Eigennutzung entfällt die Angabe eines Verantwortlichen. Bei Weitergabe der App sollten folgende Felder ausgefüllt werden:

- Name: `[Dein Name]`
- Adresse: `[Deine Adresse]`
- Kontakt-E-Mail: `[Deine E-Mail]`

---

## Was die App macht

Innenkompass ist eine lokal-first Mobile App zur Selbstreflexion und Selbstregulation. Sie speichert Situationseinträge, Krisenplan-Inhalte und App-Einstellungen primär auf dem Gerät des Nutzers.

In bestimmten privaten Builds kann zusätzlich eine optionale KI-Auswertung aktiviert sein. Dann werden für eine vom Nutzer bewusst angeforderte Auswertung ausgewählte Eintragsdaten an einen konfigurierten Edge-Worker und den dahinterliegenden KI-Anbieter übertragen.

---

## Verarbeitete Daten

- Vom Nutzer eingegebene Situationseinträge (Ereignis, Emotion, Gedanken, Impulse)
- Vom Nutzer eingegebene Krisenplan-Inhalte (Warnsignale, Coping-Strategien, Kontakte, Ressourcen)
- App-Einstellungen wie Sprache, Lock-Präferenz, Notification-Einstellungen
- Optional: Lokale Lock-Zugangsdaten (PIN, biometrische Daten) – gespeichert via platform-eigenem Secure Storage
- Optional: Export-Dateien, die nur bei expliziter Nutzeraktion erstellt werden
- Optional: Ausgewählte Eintragsdaten für eine explizit angeforderte KI-Auswertung in entsprechend konfigurierten Privat-Builds

---

## Speichermodell

- **Primär lokal:** Die reguläre Nutzung speichert Daten lokal auf dem Gerät
- **Keine Cloud-Synchronisierung:** Es gibt keinen Account-Zwang und keine automatische Synchronisierung auf einen Cloud-Speicher
- **Kein Tracking:** Die App enthält keine Analytics- oder Telemetrie-Komponenten
- **Keine automatische Datenweitergabe:** Übermittlungen an Dritte erfolgen nur bei explizitem Export oder bei bewusst angeforderter optionaler KI-Auswertung

---

## Benachrichtigungen

Wenn der Nutzer Erinnerungen aktiviert, plant die App lokale Benachrichtigungen auf dem Gerät. Der Inhalt kann im diskreten Modus konfiguriert werden, um sensible Texte auf dem Sperrbildschirm zu vermeiden.

---

## Optionale KI-Auswertung

In speziell dafür konfigurierten Privat-Builds kann der Nutzer eine zusätzliche KI-Auswertung einzelner Einträge anfordern.

- Die Funktion ist optional und nicht Bestandteil jeder App-Version
- Die Übertragung erfolgt nur auf explizite Nutzeraktion
- Es werden nur die für die Auswertung nötigen Eintragsdaten gesendet
- Die Auswertung dient der ergänzenden Einordnung und ersetzt keine professionelle Hilfe
- Für solche Builds sollte der konkrete Worker-/Anbieterpfad dokumentiert werden

---

## Datenexport

Wenn der Nutzer Daten exportiert, wird eine Datei lokal erstellt und kann über den System-Share-Flow geteilt werden (z.B. per E-Mail, Cloud-Speicher). Dieser Vorgang wird ausschließlich vom Nutzer initiiert und kontrolliert.

---

## App-Sperre (Lock)

Die App bietet eine optionale Sperre via Biometrie (Fingerabdruck, Face ID) oder PIN. Die Zugangsdaten werden im platform-eigenen Secure Storage gespeichert und sind für andere Apps nicht zugänglich.

---

## Datenlöschung

Der Nutzer kann alle gespeicherten Daten jederzeit über die Einstellungen löschen ("Alle Daten löschen"). Diese Aktion entfernt:
- Alle Situationseinträge
- Alle Krisenplan-Inhalte
- Alle App-Einstellungen
- Gespeicherte Lock-Zugangsdaten

---

## Rechte des Nutzers

Da alle Daten lokal gespeichert sind, hat der Nutzer volle Kontrolle über seine Daten:
- **Auskunft:** Der Nutzer kann alle gespeicherten Daten im Verlauf und Krisenplan einsehen
- **Export:** Der Nutzer kann Daten exportieren (Einstellungen → Datenexport)
- **Löschung:** Der Nutzer kann alle Daten löschen (Einstellungen → Alle Daten löschen)

---

## Kontakt für Datenschutzanfragen

Bei Fragen zum Datenschutz (bei Weitergabe der App):

- E-Mail: `[Deine E-Mail-Adresse]`

---

## Krisen-Hinweis

Innenkompass ist ein Selbsthilfe-Tool und ersetzt keine Notfallversorgung oder professionelle medizinische Betreuung. Die App ist kein Krisendienst und sollte nicht als solcher verstanden werden.

Bei akuter Gefahr oder Suizidalität wenden Sie sich bitte an:
- **Notruf:** 112 (EU-weit)
- **Telefonseelsorge:** 0800 111 0 111 (kostenlos, 24/7, Deutschland)
- **Örtliche Krisendienste** (in der App im Krisenplan hinterlegbar)

---

## Änderungen dieses Hinweises

Dieser Datenschutzhinweis kann bei Bedarf angepasst werden. Der aktuelle Stand ist direkt in der App oder im Repository einsehbar.

---

## Hinweis für Entwickler

Bei reiner **privater Eigennutzung** sind viele formale Datenschutz-Anforderungen reduziert. Dieses Dokument dient als Vorlage und sollte bei:
- **Weitergabe an Dritte** (auch kostenlos)
- **Kommerzieller Nutzung**
- **Aktivierter optionaler KI-Auswertung**

rechtlich geprüft und angepasst werden.
