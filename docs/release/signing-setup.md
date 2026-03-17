# Innenkompass Release Signing Setup

## Android

1. Create a release keystore outside git, for example in `android/keystore/`.
2. Copy `android/key.properties.example` to `android/key.properties`.
3. Fill in the real values:

```properties
storePassword=REPLACE_WITH_STORE_PASSWORD
keyPassword=REPLACE_WITH_KEY_PASSWORD
keyAlias=REPLACE_WITH_KEY_ALIAS
storeFile=../keystore/release-keystore.jks
```

4. Build the release artifact:

```bash
flutter build appbundle --release
```

The Gradle configuration now fails fast if `android/key.properties` is missing, so unsigned debug-style release builds are blocked intentionally.

## iOS

1. Open `ios/Runner.xcworkspace` in Xcode.
2. Select the correct Apple Team and bundle signing profile.
3. Verify the release configuration on a physical device.
4. Build the archive from Xcode or with:

```bash
flutter build ios --release
```

## Pre-release check

- Android release keystore exists and is not committed.
- `android/key.properties` exists locally and is gitignored.
- iOS signing identity and provisioning profile resolve without manual fixes.
- Release builds install on at least one Android device and one iPhone.
