# Innenkompass APK Build Setup für private Nutzung

## Standardweg: Debug-APK (empfohlen für private Nutzung)

Für die private Eigennutzung reicht eine Debug-APK vollständig aus. Diese ist ohne Signierung sofort installierbar.

```bash
flutter build apk --debug
```

Die fertige Datei liegt danach unter:

```text
build/app/outputs/flutter-apk/app-debug.apk
```

Installation auf dem Android-Gerät per USB:

```bash
adb install -r build/app/outputs/flutter-apk/app-debug.apk
```

**Hinweis:** Auf dem Zielgerät muss ggf. "Installation aus unbekannten Quellen" erlaubt werden (Android-Einstellung).

---

## Optional: Release-APK (nur bei Verteilung an Dritte)

Eine Release-APK ist **nur nötig**, wenn:
- Die App an Dritte weitergegeben werden soll
- Eine optimierte Performance benötigt wird
- Die App langfristig auf mehreren Geräten laufen soll

### Signing-Setup (nur für Release-APK)

1. Keystore außerhalb von Git erstellen, z.B. in `android/keystore/`:

```bash
keytool -genkey -v -keystore android/keystore/release-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias innenkompass
```

2. `android/key.properties.example` nach `android/key.properties` kopieren:

```bash
cp android/key.properties.example android/key.properties
```

3. Werte in `android/key.properties` anpassen:

```properties
storePassword=DEIN_STORE_PASSWORT
keyPassword=DEIN_KEY_PASSWORT
keyAlias=innenkompass
storeFile=../keystore/release-keystore.jks
```

4. Release-APK bauen:

```bash
flutter build apk --release
```

Die signierte APK liegt unter: `build/app/outputs/flutter-apk/release/app-release.apk`

---

## Prüfpunkte für private Nutzung

- [ ] Debug-APK baut ohne Signing-Setup
- [ ] APK lässt sich auf eigenem Gerät installieren
- [ ] App startet und funktioniert wie erwartet

## Prüfpunkte bei Verteilung (optional)

- [ ] `android/key.properties` existiert nur lokal (nicht in Git committen!)
- [ ] Keystore existiert und ist gesichert (bei Verlust keine Updates mehr möglich)
- [ ] Release-APK baut erfolgreich mit Signierung
- [ ] `docs/legal/privacy-policy-template.md` und `docs/legal/support-template.md` für den konkreten Privat-Build geprüft
- [ ] Bei aktivierter KI-Auswertung ist die externe Datenübertragung im Datenschutzhinweis klar beschrieben
