import 'dart:async';
import 'package:flutter/material.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/app/theme/colors.dart';

/// Interaktive Atemübung mit animiertem Kreis
///
/// Unterstützt verschiedene Atemmuster:
/// - Standard: 4-6-8 (4 Sek ein, 6 Sek halten, 8 Sek aus)
/// - Beruhigend: 4-7-8 (4 Sek ein, 7 Sek halten, 8 Sek aus)
/// - Aktivierend: 4-0-4 (4 Sek ein, 0 Sek halten, 4 Sek aus)
class BreathingExercise extends StatefulWidget {
  final int inhaleDuration;
  final int holdDuration;
  final int exhaleDuration;
  final int totalCycles;
  final VoidCallback? onComplete;

  const BreathingExercise({
    super.key,
    this.inhaleDuration = 4,
    this.holdDuration = 6,
    this.exhaleDuration = 8,
    this.totalCycles = 6,
    this.onComplete,
  });

  @override
  State<BreathingExercise> createState() => _BreathingExerciseState();
}

class _BreathingExerciseState extends State<BreathingExercise>
    with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late AnimationController _phaseController;
  late Animation<double> _scaleAnimation;

  BreathingPhase _currentPhase = BreathingPhase.inhale;
  int _currentCycle = 0;
  int _countdown = 0;
  Timer? _countdownTimer;
  bool _isRunning = false;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();

    // Breathing-Animation: Skaliert den Kreis
    _breathingController = AnimationController(
      duration: Duration(
        milliseconds: (widget.inhaleDuration +
                widget.holdDuration +
                widget.exhaleDuration) *
            1000,
      ),
      vsync: this,
    );

    _phaseController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _breathingController,
        curve: Curves.easeInOut,
      ),
    );

    _breathingController.addListener(() {
      setState(() {});
    });

    _breathingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _breathingController.reset();
        _nextCycle();
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _breathingController.dispose();
    _phaseController.dispose();
    super.dispose();
  }

  void _startBreathing() {
    setState(() {
      _isRunning = true;
      _isPaused = false;
      _currentCycle = 1;
      _currentPhase = BreathingPhase.inhale;
    });
    _startPhase(BreathingPhase.inhale);
  }

  void _pauseBreathing() {
    setState(() {
      _isPaused = !_isPaused;
    });

    if (_isPaused) {
      _countdownTimer?.cancel();
      _breathingController.stop();
    } else {
      _startPhase(_currentPhase);
    }
  }

  void _resetBreathing() {
    _countdownTimer?.cancel();
    _breathingController.reset();
    setState(() {
      _isRunning = false;
      _isPaused = false;
      _currentCycle = 0;
      _currentPhase = BreathingPhase.inhale;
      _countdown = 0;
    });
  }

  void _startPhase(BreathingPhase phase) {
    setState(() {
      _currentPhase = phase;
      _countdown = _getDurationForPhase(phase);
    });

    if (_isPaused) return;

    // Countdown starten
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPaused) return;

      setState(() {
        _countdown--;
      });

      if (_countdown <= 0) {
        timer.cancel();
        _nextPhase();
      }
    });

    // Animation basierend auf Phase steuern
    switch (phase) {
      case BreathingPhase.inhale:
        _breathingController.forward(from: 0);
        break;
      case BreathingPhase.hold:
        // Animation pausieren während Halten
        _breathingController.stop();
        break;
      case BreathingPhase.exhale:
        _breathingController.reverse(from: 1);
        break;
    }
  }

  void _nextPhase() {
    if (_isPaused) return;

    switch (_currentPhase) {
      case BreathingPhase.inhale:
        if (widget.holdDuration > 0) {
          _startPhase(BreathingPhase.hold);
        } else {
          _startPhase(BreathingPhase.exhale);
        }
        break;
      case BreathingPhase.hold:
        _startPhase(BreathingPhase.exhale);
        break;
      case BreathingPhase.exhale:
        _nextCycle();
        break;
    }
  }

  void _nextCycle() {
    if (_currentCycle >= widget.totalCycles) {
      _countdownTimer?.cancel();
      setState(() {
        _isRunning = false;
      });
      widget.onComplete?.call();
      return;
    }

    setState(() {
      _currentCycle++;
    });

    // Kurze Pause zwischen Zyklen
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!_isPaused && mounted) {
        _startPhase(BreathingPhase.inhale);
      }
    });
  }

  int _getDurationForPhase(BreathingPhase phase) {
    switch (phase) {
      case BreathingPhase.inhale:
        return widget.inhaleDuration;
      case BreathingPhase.hold:
        return widget.holdDuration;
      case BreathingPhase.exhale:
        return widget.exhaleDuration;
    }
  }

  String _getPhaseText() {
    switch (_currentPhase) {
      case BreathingPhase.inhale:
        return 'Atme ein';
      case BreathingPhase.hold:
        return 'Halte';
      case BreathingPhase.exhale:
        return 'Atme aus';
    }
  }

  String _getPhaseInstruction() {
    switch (_currentPhase) {
      case BreathingPhase.inhale:
        return 'Atme langsam durch die Nase ein';
      case BreathingPhase.hold:
        return 'Halte die Luft an';
      case BreathingPhase.exhale:
        return 'Atme langsam durch den Mund aus';
    }
  }

  Color _getPhaseColor() {
    switch (_currentPhase) {
      case BreathingPhase.inhale:
        return AppColors.success; // Grün für Einatmen
      case BreathingPhase.hold:
        return AppColors.warning; // Orange für Halten
      case BreathingPhase.exhale:
        return AppColors.secondary; // Grau-Blau für Ausatmen
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.6;

    return Column(
      children: [
        // Atemkreis mit Animation
        SizedBox(
          height: size,
          width: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Äußerer Ring
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _getPhaseColor().withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
              ),

              // Animierter Kreis
              AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: size * 0.8,
                      height: size * 0.8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            _getPhaseColor().withValues(alpha: 0.8),
                            _getPhaseColor().withValues(alpha: 0.4),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _getPhaseColor().withValues(alpha: 0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '$_countdown',
                          style: const TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: AppConstants.spacingLarge),

        // Anweisungstext
        Text(
          _getPhaseText(),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: _getPhaseColor(),
              ),
        ),

        const SizedBox(height: AppConstants.spacingSmall),

        Text(
          _getPhaseInstruction(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: AppConstants.spacingLarge),

        // Zyklus-Anzeige
        if (!_isRunning || _currentCycle > 0)
          Text(
            'Zyklus $_currentCycle von ${widget.totalCycles}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),

        const SizedBox(height: AppConstants.spacingLarge),

        // Controls
        if (!_isRunning) ...[
          ElevatedButton.icon(
            onPressed: _startBreathing,
            icon: const Icon(Icons.play_arrow),
            label: const Text('Starten'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: Colors.white,
              minimumSize: const Size(120, 48),
            ),
          ),
        ] else ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _pauseBreathing,
                icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
                label: Text(_isPaused ? 'Weiter' : 'Pause'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 48),
                ),
              ),
              const SizedBox(width: AppConstants.spacingMedium),
              ElevatedButton.icon(
                onPressed: _resetBreathing,
                icon: const Icon(Icons.refresh),
                label: const Text('Neu starten'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120, 48),
                ),
              ),
            ],
          ),
        ],

        const SizedBox(height: AppConstants.spacingMedium),

        // Hinweis
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingMedium),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
              const SizedBox(width: AppConstants.spacingSmall),
              Expanded(
                child: Text(
                  'Falls du schwindlig wirst, pausiere die Übung oder atme normal weiter.',
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Phasen der Atemübung
enum BreathingPhase { inhale, hold, exhale }
