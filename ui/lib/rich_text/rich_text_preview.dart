import 'package:dart_quill_delta/dart_quill_delta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';

class RichTextPreview extends StatefulWidget {
  const RichTextPreview({required this.delta, super.key});

  final Delta delta;

  @override
  State<RichTextPreview> createState() => _RichTextPreviewState();
}

class _RichTextPreviewState extends State<RichTextPreview> {
  final _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    _controller.document = Document.fromDelta(widget.delta);
    _controller.readOnly = true;
  }

  @override
  Widget build(BuildContext context) {
    const config = QuillEditorConfig();
    final newConfig = config.copyWith(
      expands: false,
      autoFocus: false,
      showCursor: false,
      checkBoxReadOnly: true,
      scrollable: false,
      characterShortcutEvents: [],
      onKeyPressed: (event, node) {
        if (event is! KeyDownEvent) {
          return KeyEventResult.handled;
        }

        final isCopy = event.logicalKey == LogicalKeyboardKey.keyC;
        final isCtrlOrCmd = HardwareKeyboard.instance.logicalKeysPressed.any(
          (key) =>
              key == LogicalKeyboardKey.controlLeft ||
              key == LogicalKeyboardKey.controlRight ||
              key == LogicalKeyboardKey.metaLeft ||
              key == LogicalKeyboardKey.metaRight,
        );

        if (isCtrlOrCmd && isCopy) {
          return KeyEventResult.ignored;
        }

        return KeyEventResult.handled;
      },
      textSelectionControls: EmptyTextSelectionControls(),
    );
    return QuillEditor.basic(
      controller: _controller,
      config: newConfig,
    );
  }
}

class RichTextPlainPreview extends StatelessWidget {
  const RichTextPlainPreview({required this.delta, super.key});

  final Delta delta;

  @override
  Widget build(BuildContext context) {
    final document = Document.fromDelta(delta);
    return Text(
      document.toPlainText().trim().replaceAll('\n', ' '),
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
    );
  }
}
