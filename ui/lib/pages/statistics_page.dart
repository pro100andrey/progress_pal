import 'package:flutter/material.dart';

import '../charts/weight_chart.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Column(
      children: [
        Center(child: WeightChart(title: 'Weight over Time')),
      ],
    ),
  );
}
