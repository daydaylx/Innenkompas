# Innenkompass Go-Live Checklist

## Release
- Android `key.properties` from `android/key.properties.example` filled with real signing values
- Release keystore stored outside git
- iOS signing/team configured in Xcode
- Android and iOS release builds install successfully on real devices
- Follow `docs/release/signing-setup.md`

## Product Validation
- First launch, onboarding, lock screen, and splash verified
- New situation flow tested end-to-end
- Intervention and post-evaluation tested end-to-end
- History, patterns, and crisis plan tested with existing data
- Upgrade from an older local database tested without data loss
- Run the manual checklist in `docs/release/device-smoke-test.md`

## Permissions
- Notifications permission tested on Android and iOS
- Face ID / biometrics tested on physical devices
- Phone-call shortcuts tested on device

## Store / Ops
- Privacy policy reviewed and published
- Support channel reviewed and published
- App Store / Play Store copy and screenshots prepared
- CI green on the release branch
