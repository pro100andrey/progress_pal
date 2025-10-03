import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../rich_text/text_editor.dart';

class CreateSessionNoteDialog extends StatefulWidget {
  const CreateSessionNoteDialog({super.key});

  @override
  State<CreateSessionNoteDialog> createState() =>
      _CreateSessionNoteDialogState();
}

class _CreateSessionNoteDialogState extends State<CreateSessionNoteDialog> {
  final _controller = QuillController.basic();
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();

  bool _minimized = true;

  @override
  Widget build(BuildContext context) {
    final sm = context.breakpoint <= ShadTheme.of(context).breakpoints.sm;
    final effectivePadding = sm || !_minimized
        ? EdgeInsets.zero
        : const EdgeInsets.all(16);

    return Padding(
      padding: effectivePadding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final effectiveConstraints = BoxConstraints(
            maxWidth: sm || !_minimized
                ? constraints.maxWidth
                : min(constraints.maxWidth, 960),
            maxHeight: sm || !_minimized
                ? constraints.maxHeight
                : min(constraints.maxHeight, 960),
          );

          return ShadDialog(
            closeIcon: Row(
              spacing: 8,
              children: [
                if (!sm)
                  ShadIconButton.ghost(
                    icon: Icon(
                      size: 16,
                      _minimized
                          ? LucideIcons.expand200
                          : LucideIcons.shrink200,
                    ),
                    width: 20,
                    height: 20,
                    padding: EdgeInsets.zero,
                    onPressed: _toggleMinimize,
                  ),
                ShadIconButton.ghost(
                  icon: const Icon(size: 16, LucideIcons.x),
                  width: 20,
                  height: 20,
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            title: Text(S.current.addNote),
            padding: const EdgeInsets.all(16),
            scrollable: false,
            constraints: effectiveConstraints,
            child: TextEditor(
              controller: _controller,
              scrollController: _scrollController,
              focusNode: _focusNode,
            ),
          );
        },
      ),
    );
  }

  void _toggleMinimize() {
    setState(() {
      _minimized = !_minimized;
    });
  }
}
