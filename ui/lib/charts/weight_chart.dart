import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeightChart extends StatelessWidget {
  const WeightChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 360,
    child: LineChart(
      LineChartData(
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
            color: Colors.blueAccent,
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
  );
}
