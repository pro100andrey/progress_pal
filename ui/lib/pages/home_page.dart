import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.isWaiting,
    super.key,
  });

  final bool isWaiting;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: false,
      title: Text(S.current.appName),
    ),
    body: Column(
      children: [
        EasyDateTimeLinePicker(
          focusedDate: DateTime.now(),
          firstDate: DateTime(2024, 3, 18),
          lastDate: DateTime(2030, 3, 18),
          onDateChange: (date) {
            // Handle the selected date.
          },
        ),
      ],
    ),
  );
}
