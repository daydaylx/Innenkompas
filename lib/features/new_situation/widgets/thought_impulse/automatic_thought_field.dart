import 'package:flutter/material.dart';
import '../../../../app/theme/colors.dart';
import '../../../../core/constants/app_constants.dart';

/// Text field for automatic thought with character counter.
class AutomaticThoughtField extends StatefulWidget {
  const AutomaticThoughtField({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.errorText,
    this.hintText = 'Was ist dir durch den Kopf gegangen?',
  });

  final String initialValue;
  final ValueChanged<String> onChanged;
  final String? errorText;
  final String hintText;

  @override
  State<AutomaticThoughtField> createState() => _AutomaticThoughtFieldState();
}

class _AutomaticThoughtFieldState extends State<AutomaticThoughtField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AutomaticThoughtField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
    }
  }

  int get characterCount => _controller.text.trim().length;
  bool get isNearLimit =>
      characterCount > AppConstants.maxThoughtDescriptionLength * 0.9;
  bool get isAtLimit =>
      characterCount >= AppConstants.maxThoughtDescriptionLength;
  bool get hasError => widget.errorText != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: _controller,
      maxLines: 3,
      maxLength: AppConstants.maxThoughtDescriptionLength,
      textInputAction: TextInputAction.done,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorText: widget.errorText,
        helperText: 'Welcher automatische Gedanke ist dir gekommen?',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
        filled: true,
        fillColor: hasError
            ? AppColors.errorSoft
            : AppColors.surfaceStrong.withValues(alpha: 0.94),
      ),
      style: theme.textTheme.bodyLarge?.copyWith(
        color: AppColors.textPrimary,
      ),
    );
  }
}
