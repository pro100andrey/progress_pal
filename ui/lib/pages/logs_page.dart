import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import '../placeholders/no_logs.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButton: FloatingActionButton.small(
      tooltip: S.current.addSession,
      onPressed: () {},
      child: const Icon(Icons.add),
    ),
    body: Stack(
      children: [
        Center(
          child: NoLogsPlaceholder(),
        ),
      ],
    ),
  );
}
