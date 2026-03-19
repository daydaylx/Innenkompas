# Innenkompass APK-Checklist

## Build
- Debug-APK baut erfolgreich mit `flutter build apk --debug`
- APK lässt sich auf Android installieren
- Optional: Release-APK nur dann bauen, wenn echte Signierung vorhanden ist
- Follow `docs/release/signing-setup.md`
- Flutter-Version für lokale Builds und CI ist konkret festgelegt, nicht nur `stable`

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

## Recht & Support
- `docs/legal/privacy-policy-template.md` enthält keine unbehandelten `TODO-LEGAL` Felder mehr
- `docs/legal/support-template.md` enthält keine unbehandelten `TODO-SUPPORT` Felder mehr
- Die veröffentlichte Datenschutzerklärung beschreibt den tatsächlichen Datenfluss der Release-Builds
- Support-Kanal ist erreichbar und verwechselt sich nicht mit einem Krisendienst

## Optional später
- Release-Signing mit eigenem Keystore ergänzen
- CI green on the release branch
