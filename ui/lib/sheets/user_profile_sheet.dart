import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

final profile = [
  (title: 'Name', value: 'Alexandru'),
  (title: 'Username', value: 'nank1ro'),
];

class UserProfileSheet extends StatelessWidget {
  const UserProfileSheet({this.side = ShadSheetSide.right, super.key});

  final ShadSheetSide side;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadSheet(
      constraints: side == ShadSheetSide.left || side == ShadSheetSide.right
          ? const BoxConstraints(maxWidth: 512)
          : null,
      title: const Text('Edit Profile'),
      description: const Text(
        "Make changes to your profile here. Click save when you're done",
      ),
      actions: const [
        ShadButton(child: Text('Save changes')),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: profile
              .map(
                (p) => Row(
                  children: [
                    Expanded(
                      child: Text(
                        p.title,
                        textAlign: TextAlign.end,
                        style: theme.textTheme.small,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 5,
                      child: ShadInput(initialValue: p.value),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
