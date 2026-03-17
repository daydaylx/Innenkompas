import 'package:flutter/material.dart';

import '../../app/theme/colors.dart';
import '../../core/constants/app_constants.dart';

enum AppBackgroundVariant { calm, focus, crisis }

/// Shared scaffold with the app's atmospheric background.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.leading,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = true,
    this.header,
    this.backgroundVariant = AppBackgroundVariant.calm,
    this.extendBodyBehindAppBar = false,
    this.showAppBar = true,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;
  final Widget? header;
  final AppBackgroundVariant backgroundVariant;
  final bool extendBodyBehindAppBar;
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: showAppBar
          ? AppBar(
              title: Text(title),
              leading: leading,
              actions: actions,
            )
          : null,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.background,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _AmbientBackground(variant: backgroundVariant),
            SafeArea(
              child: Column(
                children: [
                  if (header != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppConstants.spacingMedium,
                        0,
                        AppConstants.spacingMedium,
                        AppConstants.spacingMedium,
                      ),
                      child: header,
                    ),
                  Expanded(child: body),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class _AmbientBackground extends StatelessWidget {
  const _AmbientBackground({required this.variant});

  final AppBackgroundVariant variant;

  @override
  Widget build(BuildContext context) {
    final topColor = switch (variant) {
      AppBackgroundVariant.calm => AppColors.primarySoft,
      AppBackgroundVariant.focus => AppColors.accentSoft,
      AppBackgroundVariant.crisis => AppColors.crisisSurface,
    };

    final bottomColor = switch (variant) {
      AppBackgroundVariant.calm => AppColors.secondarySoft,
      AppBackgroundVariant.focus => AppColors.primarySoft,
      AppBackgroundVariant.crisis => AppColors.errorSoft,
    };

    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.backgroundElevated,
                AppColors.background,
              ],
            ),
          ),
          child: const SizedBox.expand(),
        ),
        Positioned(
          top: -90,
          left: -70,
          child: _GlowBlob(
            size: 240,
            color: topColor.withValues(alpha: 0.9),
          ),
        ),
        Positioned(
          top: 120,
          right: -80,
          child: _GlowBlob(
            size: 220,
            color: bottomColor.withValues(alpha: 0.75),
          ),
        ),
        Positioned(
          bottom: -80,
          left: 20,
          child: _GlowBlob(
            size: 180,
            color: AppColors.surfaceStrong.withValues(alpha: 0.55),
          ),
        ),
      ],
    );
  }
}

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color,
              color.withValues(alpha: 0.18),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
