# Innenkompass APK-Checklist

## Build
- Debug-APK baut erfolgreich mit `flutter build apk --debug`
- APK lässt sich auf Android installieren
- Optional: Release-APK nur dann bauen, wenn echte Signierung vorhanden ist
- Follow `docs/release/signing-setup.md`

## Produktvalidierung
- First launch, onboarding, lock screen, and splash verified
- New situation flow tested end-to-end
- Intervention and post-evaluation tested end-to-end
- History, patterns, and crisis plan tested with existing data
- Upgrade from an older local database tested without data loss
- Run the manual checklist in `docs/release/device-smoke-test.md`

## Android-Funktionen
- Notifications permission tested on Android
- Biometrics / app lock tested on physical Android device
- Phone-call shortcuts tested on device

## Optional später
- Release-Signing mit eigenem Keystore ergänzen
- Privacy-/Support-Texte nur dann finalisieren, wenn die APK breiter verteilt wird
- CI green on the release branch
