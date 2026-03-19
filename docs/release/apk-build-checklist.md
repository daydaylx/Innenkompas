# Innenkompass APK-Checklist für private Nutzung

## Build
- Debug-APK baut erfolgreich mit `flutter build apk --debug`
- APK lässt sich auf Android-Gerät installieren
- Optional: Release-APK nur dann bauen, wenn Verteilung an Dritte geplant ist
- Follow `docs/release/signing-setup.md` (nur bei Release-Builds nötig)

## Produktvalidierung
- First launch, onboarding, lock screen, and splash verified
- New situation flow tested end-to-end
- Intervention and post-evaluation tested end-to-end
- History, patterns, and crisis plan tested with existing data
- Upgrade from an older local database tested without data loss
- Lock aktiviert, App gekillt, Neustart führt nicht an der Sperre vorbei
- App in Hintergrund/Vordergrund schickt bei aktivierter Sperre zuverlässig auf den Lock-Screen
- Notification-Einstellungen bleiben nach Neustart erhalten
- Datenlöschung entfernt Einträge, Einstellungen und lokale Sperrdaten tatsächlich
- Rückdatierte Einträge erscheinen im Verlauf und in Mustern nach `timestamp`, nicht nach `createdAt`
- Run the manual checklist in `docs/release/device-smoke-test.md`

## Android-Funktionen
- Notifications permission tested on Android
- Biometrics / app lock tested on physical Android device
- Phone-call shortcuts tested on device

## Hinweis zur privaten Nutzung
- Keine Store-Veröffentlichung geplant → keine Store-spezifischen Anforderungen
- Datenschutz für Eigennutzung ausreichend umgesetzt
- Bei Weitergabe an Dritte: Rechtliche Hinweise prüfen und anpassen

## Optional (nur bei Verteilung)
- Release-Signing mit eigenem Keystore ergänzen
- `docs/legal/privacy-policy-template.md` für Empfänger verfügbar machen und an den konkreten Privat-Build anpassen
- `docs/legal/support-template.md` mit Kontaktmöglichkeit füllen
- Wenn die optionale KI-Auswertung aktiviert ist: externe Datenübertragung im Datenschutzhinweis und im Weitergabekontext klar benennen
