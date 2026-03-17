import 'package:flutter/material.dart';
import '../../../../app/theme/colors.dart';
import '../../../../core/constants/app_constants.dart';

/// Date/time picker for the situation timestamp.
class TimestampPicker extends StatelessWidget {
  const TimestampPicker({
    super.key,
    required this.selectedTimestamp,
    required this.onTimestampChanged,
  });

  final DateTime selectedTimestamp;
  final ValueChanged<DateTime> onTimestampChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final isNow = _isSameMinute(selectedTimestamp, now);

    return InkWell(
      onTap: () => _showDatePicker(context),
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingMedium),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: Row(
          children: [
            Icon(
              Icons.access_time,
              color: AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: AppConstants.spacingSmall),
            Text(
              isNow ? 'Jetzt' : _formatTimestamp(selectedTimestamp),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            if (!isNow)
              Text(
                'Jetzt',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                ),
              ),
            const SizedBox(width: AppConstants.spacingSmall),
            Icon(
              Icons.arrow_drop_down,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedTimestamp.isAfter(now) ? now : selectedTimestamp,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now,
      locale: const Locale('de', 'DE'),
      confirmText: 'OK',
      cancelText: 'Abbrechen',
      helpText: 'Datum wählen',
    );

    if (selected == null || !context.mounted) return;

    if (!context.mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedTimestamp),
      confirmText: 'OK',
      cancelText: 'Abbrechen',
      helpText: 'Uhrzeit wählen',
    );

    if (time == null) return;

    final newTimestamp = DateTime(
      selected.year,
      selected.month,
      selected.day,
      time.hour,
      time.minute,
    );
    onTimestampChanged(newTimestamp);
  }

  bool _isSameMinute(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day &&
        a.hour == b.hour &&
        a.minute == b.minute;
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterdayDuration = const Duration(days: 1);

    final timestampDay =
        DateTime(timestamp.year, timestamp.month, timestamp.day);
    final difference = today.difference(timestampDay);

    String dayPrefix;
    if (difference == Duration.zero) {
      dayPrefix = 'Heute';
    } else if (difference == yesterdayDuration) {
      dayPrefix = 'Gestern';
    } else {
      dayPrefix = '${timestamp.day}.${timestamp.month}.${timestamp.year}';
    }

    final time = '${timestamp.hour.toString().padLeft(2, '0')}:'
        '${timestamp.minute.toString().padLeft(2, '0')}';

    return '$dayPrefix, $time';
  }
}
