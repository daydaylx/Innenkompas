import 'package:flutter/material.dart';
import '../../../../app/theme/colors.dart';
import '../../../../core/constants/app_constants.dart';

/// Text field for situation description with character counter.
class SituationDescriptionField extends StatefulWidget {
  const SituationDescriptionField({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.errorText,
    this.hintText = 'Was ist passiert?',
  });

  final String initialValue;
  final ValueChanged<String> onChanged;
  final String? errorText;
  final String hintText;

  @override
  State<SituationDescriptionField> createState() =>
      _SituationDescriptionFieldState();
}

class _SituationDescriptionFieldState extends State<SituationDescriptionField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SituationDescriptionField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
    }
  }

  int get characterCount => _controller.text.trim().length;
  bool get isNearLimit =>
      characterCount > AppConstants.maxSituationDescriptionLength * 0.9;
  bool get isAtLimit =>
      characterCount >= AppConstants.maxSituationDescriptionLength;
  bool get hasError => widget.errorText != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      maxLines: 4,
      maxLength: AppConstants.maxSituationDescriptionLength,
      textInputAction: TextInputAction.done,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorText: widget.errorText,
        helperText: 'Ein oder zwei Sätze reichen völlig aus.',
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
