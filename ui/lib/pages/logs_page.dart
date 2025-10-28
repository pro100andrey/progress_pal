import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../dialogs/create_session_dialog.dart';
import '../placeholders/no_logs.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButton: FloatingActionButton.small(
      tooltip: S.current.addSession,
      onPressed: () => showDialog(
        context: context,
        builder: (context) => const CreateSessionDialog(),
      ),
      child: const Icon(LucideIcons.plus),
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
