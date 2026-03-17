import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../domain/models/pattern_summary.dart';
import '../../../application/providers/intervention_providers.dart';
import '../../../shared/widgets/cards/cards.dart';

/// Preview of the last entry on the home screen.
///
/// Shows a brief summary of the most recent situation entry.
class LastEntryPreview extends ConsumerWidget {
  const LastEntryPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final entriesAsync = ref.watch(
      filteredHistoryEntriesProvider(const HistoryFilter()),
    );

    return AppCard(
      variant: AppCardVariant.soft,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.secondarySoft,
                  borderRadius:
                      BorderRadius.circular(AppConstants.borderRadius),
                ),
                child: const Icon(
                  Icons.history,
                  size: 18,
                  color: AppColors.secondaryDark,
                ),
              ),
              const SizedBox(width: AppConstants.spacingSmall),
              Text(
                'Letzter Eintrag',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          entriesAsync.when(
            loading: () => const SizedBox(
              height: 24,
              child: Center(child: LinearProgressIndicator(minHeight: 6)),
            ),
            error: (_, __) => const Text(
              'Fehler beim Laden.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
            data: (entries) {
              if (entries.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Noch keine Einträge vorhanden.',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingSmall),
                    const Text(
                      'Tippe auf "Was ist passiert?" um deinen ersten Eintrag zu erstellen.',
                      style: TextStyle(
                        color: AppColors.textTertiary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
              }

              final latest = entries.first;
              final date = latest.createdAt;
              final dateStr =
                  '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    latest.situationDescription.isNotEmpty
                        ? latest.situationDescription
                        : '(Kein Text)',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateStr,
                    style: const TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 12,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
