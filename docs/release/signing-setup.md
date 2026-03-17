# Innenkompass APK Build Setup

## Standardweg: Debug-APK

Für den aktuellen Zielzustand reicht eine installierbare Debug-APK.

```bash
flutter build apk --debug
```

Die fertige Datei liegt danach unter:

```text
build/app/outputs/flutter-apk/app-debug.apk
```

Optional kann sie direkt per `adb` installiert werden:

```bash
adb install -r build/app/outputs/flutter-apk/app-debug.apk
```

## Optional: Release-APK

Nur nötig, wenn die APK außerhalb des Entwicklungskontexts verteilt werden soll.

1. Create a release keystore outside git, for example in `android/keystore/`.
2. Copy `android/key.properties.example` to `android/key.properties`.
3. Fill in the real values:

```properties
storePassword=REPLACE_WITH_STORE_PASSWORD
keyPassword=REPLACE_WITH_KEY_PASSWORD
keyAlias=REPLACE_WITH_KEY_ALIAS
storeFile=../keystore/release-keystore.jks
```

4. Build the release APK:

```bash
flutter build apk --release
```

The Gradle configuration now fails fast if `android/key.properties` is missing, so unsigned release builds are blocked intentionally.

## Prüfpunkte

- Debug-APK builds without signing setup.
- `android/key.properties` is only required for `--release`.
- Release keystore exists and is not committed if a release APK is needed later.
