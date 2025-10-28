import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeightChart extends StatelessWidget {
  const WeightChart({
    required this.title,
    super.key,
  });

  final String title;

  List<FlSpot> get _spots => const [
    FlSpot(1, 120),
    FlSpot(3, 119),
    FlSpot(7, 115),
    FlSpot(10, 116),
    FlSpot(12, 115),
    FlSpot(13, 105),
    FlSpot(14, 107),
  ];

  double get _minY =>
      _spots.map((e) => e.y).reduce((a, b) => a < b ? a : b) - 5;
  double get _maxY =>
      _spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 5;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(
        height: 320,
        width: 640,
        child: LineChart(
          LineChartData(
            minY: _minY,
            maxY: _maxY,
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 38,

                  getTitlesWidget: (value, meta) {
                    if (value % 1 == 0) {
                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      );
                    }
                    return const Text('');
                  },
                ),
              ),
            ),

            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                color: Colors.pink,
                barWidth: 4,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),

                belowBarData: BarAreaData(
                  color: Colors.pink.withValues(alpha: 0),
                ),
                spots: const [
                  FlSpot(1, 120),
                  FlSpot(3, 119),
                  FlSpot(7, 115),
                  FlSpot(10, 116),
                  FlSpot(12, 115),
                  FlSpot(13, 105),
                  FlSpot(14, 107),
                ],
              ),
            ],
            // read about it in the LineChartData section
          ),
        ),
      ),
    ],
  );
}
