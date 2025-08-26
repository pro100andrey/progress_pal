import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import '../image/avatar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.isWaiting,
    required this.avatar,
    super.key,
  });

  final bool isWaiting;
  final AvatarSource avatar;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: false,
      title: Text(S.current.appName),
      actions: [
        Avatar(
          source: avatar,
          size: const Size.fromRadius(16),
        ),
        const SizedBox(width: 16),
      ],
    ),
    body: Column(
      spacing: 16,
      children: [
        EasyDateTimeLinePicker(
          focusedDate: DateTime.now(),
          firstDate: DateTime(2024, 3, 18),
          lastDate: DateTime(2030, 3, 18),
          onDateChange: (date) {
            // Handle the selected date.
          },
        ),
        Column(
          children: [
            Text(
              'Weight',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
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
            ),
          ],
        ),
      ],
    ),
  );
}
