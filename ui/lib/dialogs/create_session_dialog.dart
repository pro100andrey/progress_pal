import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CreateSessionDialog extends StatelessWidget {
  const CreateSessionDialog({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: LayoutBuilder(
      builder: (context, constraints) => ShadDialog(
        scrollable: false,
        constraints: BoxConstraints(
          minHeight: constraints.maxHeight,
          maxWidth: min(constraints.maxWidth, 1500),
        ),
        title: Text(DateTime.now().toString()),
        child: const Row(
          spacing: 16,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                 
                  Expanded(
                    child: ShadCard(
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 320,
              height: double.infinity,
              child: ShadCard(),
            ),
          ],
        ),
      ),
    ),
  );
}