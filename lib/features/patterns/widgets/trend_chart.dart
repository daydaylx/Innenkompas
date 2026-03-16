import 'package:flutter/material.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/app/theme/colors.dart';
import 'package:innenkompass/domain/models/pattern_summary.dart';

/// Einfaches Liniendiagramm für Trend-Daten
class TrendChart extends StatelessWidget {
  final List<TrendDataPoint> dataPoints;
  final List<TrendDataPoint>? secondaryDataPoints;

  const TrendChart({
    super.key,
    required this.dataPoints,
    this.secondaryDataPoints,
  });

  @override
  Widget build(BuildContext context) {
    if (dataPoints.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingMedium),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.show_chart, size: 48, color: Colors.grey[400]),
                const SizedBox(height: 12),
                Text(
                  'Noch nicht genug Daten für einen Trend',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header mit Legende
            Row(
              children: [
                Icon(Icons.show_chart, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Belastungsverlauf',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                if (secondaryDataPoints != null && secondaryDataPoints!.isNotEmpty)
                  Row(
                    children: [
                      _LegendItem(
                        color: AppColors.primary,
                        label: 'Belastung',
                      ),
                      const SizedBox(width: 12),
                      _LegendItem(
                        color: AppColors.secondary,
                        label: 'Anspannung',
                      ),
                    ],
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // Chart
            SizedBox(
              height: 150,
              child: _TrendChartPainter(
                dataPoints: dataPoints,
                secondaryDataPoints: secondaryDataPoints,
              ),
            ),

            const SizedBox(height: 16),

            // X-Achse Labels (erste und letzte Datenpunk)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(dataPoints.first.date),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                Text(
                  _formatDate(dataPoints.last.date),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),

            // Y-Achse Labels
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '10',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[500],
                      ),
                ),
                Text(
                  '1',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[500],
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}.${dt.month}';
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

/// Custom Painter für das Trend-Diagramm
class _TrendChartPainter extends StatelessWidget {
  final List<TrendDataPoint> dataPoints;
  final List<TrendDataPoint>? secondaryDataPoints;

  const _TrendChartPainter({
    required this.dataPoints,
    this.secondaryDataPoints,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 150),
      painter: _TrendChartPainterPainter(
        dataPoints: dataPoints,
        secondaryDataPoints: secondaryDataPoints,
      ),
    );
  }
}

class _TrendChartPainterPainter extends CustomPainter {
  final List<TrendDataPoint> dataPoints;
  final List<TrendDataPoint>? secondaryDataPoints;

  _TrendChartPainterPainter({
    required this.dataPoints,
    this.secondaryDataPoints,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (dataPoints.isEmpty) return;

    final padding = 8.0;
    final chartWidth = size.width - padding * 2;
    final chartHeight = size.height - padding * 2;

    // Y-Achse: 1-10
    final minValue = 1.0;
    final maxValue = 10.0;
    final yRange = maxValue - minValue;

    // Zeichne Grid-Linien
    final gridPaint = Paint()
      ..color = Colors.grey[200]!
      ..strokeWidth = 1;

    for (int i = 0; i <= 5; i++) {
      final y = padding + (chartHeight / 5) * i;
      canvas.drawLine(
        Offset(padding, y),
        Offset(size.width - padding, y),
        gridPaint,
      );
    }

    // Hilfsfunktion: Konvertiere Datenpunkt in Chart-Koordinaten
    Offset toOffset(TrendDataPoint point, int index) {
      final x = padding + (chartWidth / (dataPoints.length - 1)) * index;
      final normalizedValue = (point.value - minValue) / yRange;
      final y = size.height - padding - (normalizedValue * chartHeight);
      return Offset(x, y);
    }

    // Zeichne primäre Linie (Belastung)
    if (dataPoints.length > 1) {
      final primaryPaint = Paint()
        ..color = AppColors.primary
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      final path = Path();
      final firstPoint = toOffset(dataPoints.first, 0);
      path.moveTo(firstPoint.dx, firstPoint.dy);

      for (int i = 1; i < dataPoints.length; i++) {
        final point = toOffset(dataPoints[i], i);
        path.lineTo(point.dx, point.dy);
      }

      canvas.drawPath(path, primaryPaint);
    }

    // Zeichne sekundäre Linie (Körperanspannung)
    if (secondaryDataPoints != null && secondaryDataPoints!.length > 1) {
      final secondaryPaint = Paint()
        ..color = AppColors.secondary
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      final path = Path();
      final firstPoint = toOffset(secondaryDataPoints!.first, 0);
      path.moveTo(firstPoint.dx, firstPoint.dy);

      for (int i = 1; i < secondaryDataPoints!.length; i++) {
        final point = toOffset(secondaryDataPoints![i], i);
        path.lineTo(point.dx, point.dy);
      }

      canvas.drawPath(path, secondaryPaint);
    }

    // Zeichne Datenpunkte (primär)
    final dotPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    for (int i = 0; i < dataPoints.length; i++) {
      final offset = toOffset(dataPoints[i], i);
      canvas.drawCircle(offset, 4, dotPaint);
    }

    // Zeichne Datenpunkte (sekundär)
    if (secondaryDataPoints != null) {
      final secondaryDotPaint = Paint()
        ..color = AppColors.secondary
        ..style = PaintingStyle.fill;

      for (int i = 0; i < secondaryDataPoints!.length; i++) {
        final offset = toOffset(secondaryDataPoints![i], i);
        canvas.drawCircle(offset, 3, secondaryDotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
