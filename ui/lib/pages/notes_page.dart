import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import '../placeholders/no_notes.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButton: FloatingActionButton.small(
      tooltip: S.current.addNote,
      onPressed: () {},
      child: const Icon(Icons.add),
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
