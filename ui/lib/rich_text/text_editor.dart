import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TextEditor extends StatelessWidget {
  const TextEditor({
    required this.controller,
    required this.scrollController,
    required this.focusNode,
    super.key,
  });

  final QuillController controller;
  final ScrollController scrollController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final mTheme = Theme.of(context);
    return Theme(
      data:
          ThemeData.from(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green,
              brightness: theme.brightness,
            ),
          ).copyWith(
            dialogTheme: mTheme.dialogTheme.copyWith(
              backgroundColor: theme.colorScheme.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
      child: Column(
        children: [
          QuillSimpleToolbar(
            controller: controller,
            config: const QuillSimpleToolbarConfig(
              showFontFamily: false,
              showColorButton: false,
              showListCheck: false,
              showBackgroundColorButton: false,
              showCodeBlock: false,
              showFontSize: false,
              showInlineCode: false,
              showSubscript: false,
              showSuperscript: false,
              showAlignmentButtons: true,
            ),
          ),
          const ShadSeparator.horizontal(
            thickness: 1,
            margin: EdgeInsets.symmetric(vertical: 2),
          ),
          Expanded(
            child: QuillEditor.basic(
              focusNode: focusNode,
              config: QuillEditorConfig(
                placeholder: S.current.startTyping,
                padding: const EdgeInsets.all(8),
                textSelectionThemeData: TextSelectionThemeData(
                  selectionColor: theme.colorScheme.primary.withAlpha(40),
                  cursorColor: theme.colorScheme.primary,
                  selectionHandleColor: theme.colorScheme.primary,
                ),
              ),
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
