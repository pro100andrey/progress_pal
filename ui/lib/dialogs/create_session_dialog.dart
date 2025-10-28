import 'dart:math';

import 'package:flutter/material.dart';

class CreateSessionDialog extends StatelessWidget {
  const CreateSessionDialog({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: LayoutBuilder(
      builder: (context, constraints) => AlertDialog(
        constraints: BoxConstraints(
          minHeight: constraints.maxHeight,
          maxWidth: min(constraints.maxWidth, 1500),
        ),
        title: Text(DateTime.now().toString()),
        content: const Row(
          spacing: 16,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  TimeRange(),
                  Expanded(
                    child: Card(),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 320,
              height: double.infinity,
              child: Card(),
            ),
          ],
        ),
      ),
    ),
  );
}

class TimeRange extends StatelessWidget {
  const TimeRange({
    super.key,
  });

  @override
  Widget build(BuildContext context) => const Row(
    spacing: 16,
    children: [
      TimePicker(label: 'From:'),
      TimePicker(label: 'To:'),
    ],
  );
}

class TimePicker extends StatelessWidget {
  const TimePicker({
    required this.label,
    super.key,
  });

  final String label;

  @override
  Widget build(BuildContext context) => const Placeholder();
}
