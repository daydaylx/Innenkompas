import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../core/constants/app_constants.dart';

class FormTextArea extends StatefulWidget {
  const FormTextArea({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.maxLength,
    this.maxLines = 4,
    this.hintText,
    this.helperText,
    this.errorText,
  });

  final String initialValue;
  final ValueChanged<String> onChanged;
  final int maxLength;
  final int maxLines;
  final String? hintText;
  final String? helperText;
  final String? errorText;

  @override
  State<FormTextArea> createState() => _FormTextAreaState();
}

class _FormTextAreaState extends State<FormTextArea> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant FormTextArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;

    return TextField(
      controller: _controller,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        helperText: widget.helperText,
        errorText: widget.errorText,
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
    );
  }
}
