import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/colors.dart';
import '../../../application/providers/lock_provider.dart';
import 'app_list_tile.dart';

/// Toggle widget for app lock in settings.
class AppLockToggle extends ConsumerWidget {
  const AppLockToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lockState = ref.watch(lockStateProvider);

    final subtitle = lockState.isEnabled
        ? _lockTypeLabel(lockState.lockType)
        : 'Deaktiviert';

    return AppListTile(
      leading: Icon(
        lockState.isEnabled ? Icons.lock_outline : Icons.lock_open_outlined,
      ),
      title: 'App-Sperre',
      subtitle: subtitle,
      trailing: Switch(
        value: lockState.isEnabled,
        onChanged: (value) =>
            value ? _enableLock(context, ref) : _disableLock(context, ref),
      ),
    );
  }

  String _lockTypeLabel(String? type) {
    switch (type) {
      case 'biometric':
        return 'Biometrisch';
      case 'pin':
        return 'PIN-Code';
      case 'biometric_and_pin':
        return 'Biometrie + PIN';
      default:
        return 'Aktiviert';
    }
  }

  Future<void> _enableLock(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(lockStateProvider.notifier);
    final isBiometricAvailable = await notifier.isBiometricAvailable();

    if (!context.mounted) return;

    if (isBiometricAvailable) {
      final choice = await showDialog<String>(
        context: context,
        builder: (ctx) => SimpleDialog(
          title: const Text('App-Sperre wählen'),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.pop(ctx, 'biometric'),
              child: const ListTile(
                leading: Icon(Icons.fingerprint),
                title: Text('Biometrisch'),
                subtitle: Text('Fingerabdruck oder Gesichtserkennung'),
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(ctx, 'pin'),
              child: const ListTile(
                leading: Icon(Icons.pin_outlined),
                title: Text('PIN-Code'),
                subtitle: Text('4-6 stelliger Code'),
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(ctx, 'biometric_and_pin'),
              child: const ListTile(
                leading: Icon(Icons.security),
                title: Text('Beides'),
                subtitle: Text('Biometrie mit PIN-Fallback'),
              ),
            ),
          ],
        ),
      );

      if (!context.mounted || choice == null) return;

      if (choice == 'pin' || choice == 'biometric_and_pin') {
        final pin = await _showPinDialog(context);
        if (!context.mounted || pin == null) return;
        await notifier.setPin(pin);
      }

      if (!context.mounted) return;
      await notifier.enableLock(choice);
    } else {
      // Only PIN available
      final pin = await _showPinDialog(context);
      if (!context.mounted || pin == null) return;
      await notifier.setPin(pin);
      if (!context.mounted) return;
      await notifier.enableLock('pin');
    }
  }

  Future<void> _disableLock(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('App-Sperre deaktivieren?'),
        content: const Text(
          'Die App-Sperre schützt deine Daten beim Öffnen der App. '
          'Möchtest du sie wirklich deaktivieren?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Deaktivieren'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(lockStateProvider.notifier).disableLock();
    }
  }

  Future<String?> _showPinDialog(BuildContext context) async {
    final controller = TextEditingController();
    final confirmController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('PIN festlegen'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controller,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  labelText: 'PIN (4-6 Ziffern)',
                  counterText: '',
                ),
                validator: (v) {
                  if (v == null || v.length < 4) {
                    return 'Mindestens 4 Ziffern';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(v)) {
                    return 'Nur Ziffern erlaubt';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: confirmController,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  labelText: 'PIN bestätigen',
                  counterText: '',
                ),
                validator: (v) {
                  if (v != controller.text) {
                    return 'PINs stimmen nicht überein';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(ctx, controller.text);
              }
            },
            child: const Text('Speichern'),
          ),
        ],
      ),
    );
  }
}
