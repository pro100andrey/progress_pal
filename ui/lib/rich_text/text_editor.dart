import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

typedef Delta = List<Map<String, dynamic>>;

class TextEditor extends StatefulWidget {
  const TextEditor({
    this.onDeltaChanged,
    super.key,
  });

  final ValueChanged<Delta>? onDeltaChanged;

  @override
  State<TextEditor> createState() => TextEditorState();
}

class TextEditorState extends State<TextEditor> {
  final _controller = QuillController.basic();
  final _focusNode = FocusNode();

  var _write = true;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShadSwitch(
                value: _write,
                onChanged: (v) => _toggleWrite(value: v),
                label: const Text('Write'),
              ),

              if (widget.onDeltaChanged != null) ...[
                const Spacer(),
                ShadButton.ghost(
                  onPressed: () {
                    widget.onDeltaChanged?.call(getDelta());
                  },
                  child: Text(S.current.save),
                ),
              ],
            ],
          ),
          const ShadSeparator.horizontal(
            thickness: 1,
            margin: EdgeInsets.symmetric(vertical: 8),
          ),
          Expanded(
            child: QuillEditor.basic(
              focusNode: _focusNode,
              config: QuillEditorConfig(
                placeholder: _write ? S.current.startTyping : null,
                padding: const EdgeInsets.all(8),
                autoFocus: true,
                textSelectionThemeData: TextSelectionThemeData(
                  selectionColor: theme.colorScheme.primary.withAlpha(40),
                  cursorColor: theme.colorScheme.primary,
                  selectionHandleColor: theme.colorScheme.primary,
                ),
              ),

              controller: _controller,
            ),
          ),

          if (_write)
            QuillSimpleToolbar(
              controller: _controller,
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
        ],
      ),
    );
  }

  void _toggleWrite({required bool value}) {
    setState(() {
      _controller.readOnly = !value;
      value ? _focusNode.requestFocus() : _focusNode.unfocus();
      _controller.updateSelection(
        const TextSelection.collapsed(offset: 0),
        ChangeSource.local,
      );
      _write = value;
    });
  }

  List<Map<String, dynamic>> getDelta() {
    final delta = _controller.document.toDelta().toJson();

    return delta;
  }
}
