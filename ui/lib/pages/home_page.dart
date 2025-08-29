import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../charts/weight_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.isWaiting,

    required this.profileMenu,
    super.key,
  });

  final bool isWaiting;
  final Widget profileMenu;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [
        if (!isWaiting) profileMenu,
      ],
    ),
    body: const Center(child: Text('Home')),
  );
}

// ignore: unused_element
class _HomeWidget extends StatelessWidget {
  const _HomeWidget();

  @override
  Widget build(BuildContext context) => Column(
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
      const Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: ShadAlert(
                  iconData: LucideIcons.terminal,
                  title: Text('Heads up!'),
                  description: Text(
                    'You are having one not completed challenge.',
                  ),
                ),
              ),
              ShadTabs<String>(
                value: 'Statistics',
                scrollable: true,
                tabs: [
                  ShadTab(
                    value: 'Statistics',
                    content: Wrap(
                      runSpacing: 16,
                      alignment: WrapAlignment.spaceAround,
                      children: [
                        WeightChart(title: 'Weight'),
                        WeightChart(title: 'Height'),
                      ],
                    ),
                    child: Text('Statistics'),
                  ),
                  ShadTab(
                    value: 'Trackers',
                    content: Text('Trackers'),
                    child: Text('Trackers'),
                  ),
                  ShadTab(
                    value: 'Trainings',
                    content: Text('Trainings'),
                    child: Text('Trainings'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
