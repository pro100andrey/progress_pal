import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../dialogs/create_session_note_dialog.dart';
import '../placeholders/no_notes.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButton: FloatingActionButton.small(
      tooltip: S.current.addNote,
      onPressed: () => showDialog(
        context: context,
        builder: (context) => const CreateSessionNoteDialog(),
      ),
      child: const Icon(LucideIcons.plus),
    ),
    body: Stack(
      children: [
        Center(
          child: NoNotesPlaceholder(),
        ),
      ],
    ),
  );
}
