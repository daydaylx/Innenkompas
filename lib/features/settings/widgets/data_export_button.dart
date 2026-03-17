import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../app/theme/colors.dart';
import '../../../application/providers/database_provider.dart';
import 'app_list_tile.dart';

/// Button for exporting all data as JSON.
class DataExportButton extends ConsumerWidget {
  const DataExportButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppListTile(
      leading: const Icon(Icons.upload_outlined),
      title: 'Daten exportieren',
      subtitle: 'Alle Daten als JSON-Datei teilen',
      onTap: () => _exportData(context, ref),
    );
  }

  Future<void> _exportData(BuildContext context, WidgetRef ref) async {
    try {
      final db = ref.read(databaseProvider);
      final data = await db.exportToJson();

      // Write to temporary file
      final dir = await getTemporaryDirectory();
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final file = File('${dir.path}/innenkompass_export_$timestamp.json');
      await file.writeAsString(
        const JsonEncoder.withIndent('  ').convert(data),
      );

      // Share the file
      if (context.mounted) {
        await Share.shareXFiles(
          [XFile(file.path)],
          text: 'Innenkompass Datenexport',
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler beim Export: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}
