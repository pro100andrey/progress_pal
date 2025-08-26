import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../charts/weight_chart.dart';
import '../image/avatar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.isWaiting,
    required this.avatar,
    required this.userProfile,
    super.key,
  });

  final bool isWaiting;
  final AvatarSource avatar;
  final Widget userProfile;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: false,
      title: Text(S.current.appName),
      actions: [
        Avatar(
          source: avatar,
          size: const Size.fromRadius(16),
          onTap: () => showShadSheet(
            side: ShadSheetSide.right,
            context: context,
            builder: (context) => userProfile,
          ),
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
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                'Weight',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const WeightChart(),
            ],
          ),
        ),
      ],
    ),
  );
}
