# Innenkompass Android APK Smoke Test

## Installation

- Build the APK with `flutter build apk --debug`.
- Install the APK on an Android device or emulator.
- Launch the app from the installed package, not from `flutter run`.

## Cold Start

- App starts into the splash screen.
- Splash transitions into onboarding on a fresh install.
- After onboarding completion, the app opens the home screen on relaunch.

## Core Product Flow

- Create a new situation from Home.
- Complete all situation steps including `Bedürfnis / verletzter Punkt` and `Nächster Schritt`.
- Finish an intervention and save the post-evaluation.
- Open the saved entry in History and verify all entered content is visible.

## Patterns and Crisis

- Open `Muster` with existing entries and verify charts plus insight cards render.
- Open `Hilfe` and verify the full crisis plan is visible.
- Edit the crisis plan and confirm changes persist after app restart.

## Platform Features

- Enable notifications and verify local reminders trigger.
- Enable app lock and verify biometric unlock on an Android device with biometrics.
- Trigger phone shortcuts in the crisis area and verify the dialer opens.
- Test export/share from Settings.

## Upgrade

- Install an older build with existing entries.
- Upgrade to the current build without deleting app data.
- Verify entries, crisis plan, and settings remain intact.
