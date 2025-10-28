import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

class CreateSessionNoteDialog extends StatefulWidget {
  const CreateSessionNoteDialog({super.key});

  @override
  State<CreateSessionNoteDialog> createState() =>
      _CreateSessionNoteDialogState();
}

class _CreateSessionNoteDialogState extends State<CreateSessionNoteDialog> {
  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(S.current.addSession),
    content: const TextField(
      decoration: InputDecoration(hintText: 'Enter your note here'),
      maxLines: 5,
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(S.current.cancel),
      ),
      ElevatedButton(
        onPressed: () {
          // Logic to save the note goes here
          Navigator.of(context).pop();
        },
        child: Text(S.current.save),
      ),
    ],
  );
}
