import 'dart:async';
import 'package:flutter/material.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/app/theme/colors.dart';

/// Countdown-Timer Widget für Interventionen
///
/// Zeigt einen visuellen Countdown mit kreisförmigem Fortschritt
class TimerWidget extends StatefulWidget {
  final int durationSec;
  final String? title;
  final String? instruction;
  final VoidCallback? onComplete;

  const TimerWidget({
    super.key,
    required this.durationSec,
    this.title,
    this.instruction,
    this.onComplete,
  });

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isRunning = false;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.durationSec;

    _controller = AnimationController(
      duration: Duration(seconds: widget.durationSec),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onComplete();
      }
    });

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _start() {
    setState(() {
      _isRunning = true;
      _isPaused = false;
      _remainingSeconds = widget.durationSec;
    });

    _controller.forward(from: 0);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPaused) return;

      setState(() {
        _remainingSeconds--;
      });

      if (_remainingSeconds <= 0) {
        timer.cancel();
      }
    });
  }

  void _pause() {
    setState(() {
      _isPaused = !_isPaused;
    });

    if (_isPaused) {
      _controller.stop();
    } else {
      _controller.forward();
    }
  }

  void _reset() {
    _timer?.cancel();
    _controller.reset();
    setState(() {
      _isRunning = false;
      _isPaused = false;
      _remainingSeconds = widget.durationSec;
    });
  }

  void _onComplete() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
    widget.onComplete?.call();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.5;

    return Column(
      children: [
        // Timer-Kreis
        SizedBox(
          height: size,
          width: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Hintergrund-Kreis
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
              ),

              // Fortschritts-Kreis
              if (_isRunning)
                SizedBox(
                  width: size,
                  height: size,
                  child: CircularProgressIndicator(
                    value: _animation.value,
                    strokeWidth: 8,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getRemainingColor(),
                    ),
                  ),
                ),

              // Zeit-Anzeige
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _formatTime(_remainingSeconds),
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _getRemainingColor(),
                          ),
                    ),
                    if (_isRunning) ...[
                      const SizedBox(height: 4),
                      Text(
                        _isPaused ? 'Pausiert' : 'Verbleibend',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppConstants.spacingLarge),

        // Titel
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacingSmall),
        ],

        // Instruktion
        if (widget.instruction != null) ...[
          Text(
            widget.instruction!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacingLarge),
        ],

        // Controls
        if (!_isRunning) ...[
          ElevatedButton.icon(
            onPressed: _start,
            icon: const Icon(Icons.play_arrow),
            label: const Text('Starten'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(120, 48),
            ),
          ),
        ] else ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _pause,
                icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
                label: Text(_isPaused ? 'Weiter' : 'Pause'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 48),
                ),
              ),
              const SizedBox(width: AppConstants.spacingMedium),
              ElevatedButton.icon(
                onPressed: _reset,
                icon: const Icon(Icons.refresh),
                label: const Text('Neu starten'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120, 48),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Color _getRemainingColor() {
    if (!_isRunning) return AppColors.primary;

    final percentage = _remainingSeconds / widget.durationSec;
    if (percentage > 0.5) return AppColors.success;
    if (percentage > 0.25) return AppColors.warning;
    return AppColors.error;
  }
}
