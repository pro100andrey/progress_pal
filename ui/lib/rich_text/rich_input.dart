import 'package:dart_quill_delta/dart_quill_delta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:localization/generated/l10n.dart';

/// Signature for building a rich input bar.
typedef RichInputBarBuilder =
    Widget? Function(BuildContext context, QuillController controller);

/// A rich text input widget with a formatting toolbar.
class RichInput extends StatefulWidget {
  const RichInput({
    required this.barBuilder,
    this.readOnly = false,
    this.autofocus = false,
    this.initialValue,
    this.focusNode,
    this.controller,
    this.label,
    this.errorText,
    this.onChanged,
    this.minHeight = 200,
    this.maxHeight = 1600,
    this.enabled = true,
    super.key,
  });

  final RichInputBarBuilder barBuilder;
  final bool readOnly;
  final bool autofocus;
  final Delta? initialValue;
  final Widget? label;
  final String? errorText;
  final QuillController? controller;
  final FocusNode? focusNode;
  final bool enabled;
  final ValueChanged<Delta?>? onChanged;
  final double minHeight;
  final double maxHeight;

  @override
  State<RichInput> createState() => RichInputState();
}

class RichInputState extends State<RichInput> {
  QuillController? _controller;
  QuillController get _effectiveController => widget.controller ?? _controller!;

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode!;
  bool _hasFocus = false;
  bool _isHovering = false;

  @override
  void initState() {
    assert(
      widget.controller == null || widget.initialValue == null,
      'Cannot provide both a controller and an initialValue',
    );

    super.initState();

    if (widget.controller == null) {
      final document = widget.initialValue != null
          ? Document.fromDelta(widget.initialValue!)
          : null;
      _createLocalController(document);
    }

    if (widget.focusNode == null) {
      _focusNode = FocusNode(canRequestFocus: !widget.readOnly);
    }

    _effectiveFocusNode.addListener(_onFocusChange);
    _effectiveController.addListener(_onTextChanged);
  }

  void _createLocalController([Document? value]) {
    assert(_controller == null, 'Local controller already created');
    _controller = QuillController.basic();
    _effectiveController.readOnly = !widget.enabled || widget.readOnly;
    _effectiveController.document = value ?? Document();
  }

  @override
  void didUpdateWidget(covariant RichInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle focus node changes.
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_onFocusChange);
      _effectiveFocusNode.addListener(_onFocusChange);
    }

    // Handle controller changes.
    final hasNew = widget.controller != null;
    final hasOld = oldWidget.controller != null;
    final isSameController = widget.controller == oldWidget.controller;

    if (!hasNew && hasOld) {
      oldWidget.controller?.removeListener(_onTextChanged);
      _createLocalController(oldWidget.controller!.document);
    } else if (hasNew && !hasOld) {
      _controller?.dispose();
      _controller = null;
    } else if (hasNew && hasOld && !isSameController) {
      _effectiveController.removeListener(_onTextChanged);
      widget.controller?.addListener(_onTextChanged);
    }

    // Handle readOnly/enabled changes.
    final newReadOnly = !widget.enabled || widget.readOnly;
    final oldReadOnly = !oldWidget.enabled || oldWidget.readOnly;

    if (newReadOnly != oldReadOnly) {
      _effectiveFocusNode.canRequestFocus = !newReadOnly;
      _effectiveController.readOnly = newReadOnly;
    }
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _effectiveFocusNode.hasFocus;
    });
  }

  void _onTextChanged() {
    final document = _effectiveController.document;

    if (widget.onChanged != null) {
      widget.onChanged?.call(document.isEmpty() ? null : document.toDelta());
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_onFocusChange);

    if (widget.focusNode == null) {
      _focusNode?.dispose();
    }

    _effectiveController.removeListener(_onTextChanged);

    if (widget.controller == null) {
      _controller?.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputBar = widget.barBuilder(context, _effectiveController);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: InputDecorator(
        isFocused: _hasFocus,
        isHovering: _isHovering,
        decoration: InputDecoration(
          enabled: widget.enabled,
          label: widget.label,
          errorText: widget.errorText,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (inputBar != null) ...[
              inputBar,
              const Divider(height: 1),
            ],
            Shortcuts(
              shortcuts: const {
                SingleActivator(LogicalKeyboardKey.tab): NextFocusIntent(),
              },
              child: Actions(
                actions: {
                  NextFocusIntent: CallbackAction<NextFocusIntent>(
                    onInvoke: (intent) => _effectiveFocusNode.nextFocus(),
                  ),
                },
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyMedium!,
                  child: Builder(
                    builder: (context) {
                      const config = QuillEditorConfig();
                      final newConfig = config.copyWith(
                        expands: false,
                        minHeight: widget.minHeight,
                        maxHeight: widget.maxHeight,
                        placeholder: S.current.startTypingHere,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        autoFocus: widget.autofocus,
                      );

                      return QuillEditor.basic(
                        focusNode: _effectiveFocusNode,
                        config: newConfig,
                        controller: _effectiveController,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
