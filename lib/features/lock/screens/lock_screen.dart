import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innenkompass/app/router.dart';
import 'package:innenkompass/app/theme/colors.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/application/providers/lock_provider.dart';
import 'package:innenkompass/shared/widgets/app_scaffold.dart';
import 'package:innenkompass/shared/widgets/buttons/app_primary_button.dart';
import 'package:innenkompass/shared/widgets/buttons/app_secondary_button.dart';
import 'package:innenkompass/shared/widgets/cards/app_card.dart';

/// Full-screen lock screen shown when app is locked.
class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  final _pinController = TextEditingController();
  int _failedAttempts = 0;
  bool _isWaiting = false;
  int _waitSeconds = 0;
  bool _biometricAttempted = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tryBiometric();
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _tryBiometric() async {
    if (_biometricAttempted) return;
    _biometricAttempted = true;

    final lockState = ref.read(lockStateProvider);
    if (lockState.lockType == 'pin') return;

    final notifier = ref.read(lockStateProvider.notifier);
    final success = await notifier.authenticate();
    if (success && mounted) {
      context.go(AppRoutes.home);
    }
  }

  Future<void> _verifyPin() async {
    if (_isWaiting) return;

    final pin = _pinController.text;
    if (pin.length < 4) {
      setState(() => _errorMessage = 'Mindestens 4 Ziffern eingeben');
      return;
    }

    final notifier = ref.read(lockStateProvider.notifier);
    final success = await notifier.verifyPin(pin);

    if (success && mounted) {
      context.go(AppRoutes.home);
    } else {
      setState(() {
        _failedAttempts++;
        _errorMessage = 'Falscher PIN. Versuch $_failedAttempts/3';
        _pinController.clear();
      });

      if (_failedAttempts >= 3) {
        setState(() {
          _isWaiting = true;
          _waitSeconds = 30;
        });
        _startWaitTimer();
      }
    }
  }

  void _startWaitTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _waitSeconds--;
        if (_waitSeconds <= 0) {
          _isWaiting = false;
          _failedAttempts = 0;
          _errorMessage = null;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lockState = ref.watch(lockStateProvider);

    return AppScaffold(
      title: '',
      showAppBar: false,
      backgroundVariant: AppBackgroundVariant.focus,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingXLarge),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: AppCard(
              variant: AppCardVariant.glass,
              margin: EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.primarySoft,
                      borderRadius:
                          BorderRadius.circular(AppConstants.borderRadiusLarge),
                    ),
                    child: const Icon(
                      Icons.lock_outline,
                      size: 34,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingLarge),
                  Text(
                    'Innenkompass entsperren',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'Ein kurzer Schritt, dann bist du wieder im ruhigen Modus.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppConstants.spacingXLarge),
                  if (lockState.lockType != 'biometric') ...[
                    TextField(
                      controller: _pinController,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        letterSpacing: 8,
                      ),
                      decoration: const InputDecoration(
                        hintText: '••••',
                        counterText: '',
                      ),
                      enabled: !_isWaiting,
                      onSubmitted: (_) => _verifyPin(),
                    ),
                    const SizedBox(height: AppConstants.spacingMedium),
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    if (_isWaiting)
                      Padding(
                        padding: const EdgeInsets.only(
                            top: AppConstants.spacingSmall),
                        child: Text(
                          'Bitte $_waitSeconds Sekunden warten...',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.warning,
                          ),
                        ),
                      ),
                    const SizedBox(height: AppConstants.spacingMedium),
                    AppPrimaryButton(
                      onPressed: _isWaiting ? null : _verifyPin,
                      label: _isWaiting ? 'Warten...' : 'Entsperren',
                    ),
                  ],
                  if (lockState.lockType != 'pin') ...[
                    const SizedBox(height: AppConstants.spacingMedium),
                    AppSecondaryButton(
                      onPressed: _tryBiometric,
                      icon: Icons.fingerprint,
                      label: 'Biometrisch entsperren',
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
