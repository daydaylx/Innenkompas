import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../application/providers/settings_provider.dart';
import 'app_list_tile.dart';

/// Language selector widget for settings.
///
/// Features:
/// - DE/EN toggle
/// - Persists to user_settings.locale
class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);
    final currentLocale = settings?.locale ?? AppConstants.defaultLocale;
    final isGerman = currentLocale == 'de';

    return AppListTile(
      leading: const Icon(Icons.language),
      title: 'Sprache',
      subtitle: isGerman ? 'Deutsch' : 'English',
      trailing: Switch(
        value: isGerman,
        onChanged: (value) async {
          final newLocale = value ? 'de' : 'en';
          await ref
              .read(settingsNotifierProvider.notifier)
              .updateLocale(newLocale);
        },
      ),
    );
  }
}
