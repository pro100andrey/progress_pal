import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../models/value_changed.dart';

class InputFormField extends StatefulWidget {
  const InputFormField({
    required this.vm,
    this.id,
    this.obscureText = false,
    this.autofocus = false,
    this.showCounterText = true,
    this.expands = false,
    this.minLines,
    this.maxLines = 1,
    this.label,
    this.placeholder,
    this.description,
    this.leading,
    this.keyboardType,
    this.textAlignVertical,
    this.filled,
    this.maxLength,
    this.focusNode,
    this.inputFormatters,
    this.autofillHints,
    this.floatingLabelBehavior,
    this.onSubmitted,
    this.trailingBuilder,

    super.key,
  });

  final ValueChangedVm<String?> vm;
  final String? id;
  final bool obscureText;
  final bool autofocus;
  final bool showCounterText;
  final bool expands;
  final int? minLines;
  final int? maxLines;
  final Widget? label;
  final Widget? placeholder;
  final Widget? description;
  final Widget? leading;
  final int? maxLength;
  final bool? filled;
  final TextAlignVertical? textAlignVertical;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final List<String>? autofillHints;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final void Function(String value)? onSubmitted;

  final Widget Function(InputFormFieldState state)? trailingBuilder;

  @override
  InputFormFieldState createState() => InputFormFieldState();
}

class InputFormFieldState extends State<InputFormField> {
  final _controller = TextEditingController();
  late bool obscure;

  @override
  Widget build(BuildContext context) => ShadInputFormField(
    id: widget.id,
    controller: _controller,
    label: widget.label,
    placeholder: widget.placeholder,
    description: widget.description,
    trailing: widget.trailingBuilder?.call(this),
    leading: widget.leading,
    focusNode: widget.focusNode,
    keyboardType: widget.keyboardType,
    expands: widget.expands,
    minLines: widget.minLines,
    maxLength: widget.maxLength,
    validator: widget.vm.validator,
    maxLines: widget.maxLines,
    obscureText: obscure,
    autofocus: widget.autofocus,
    inputFormatters: widget.inputFormatters,
    onSubmitted: widget.onSubmitted,
    autofillHints: widget.autofillHints,
  );

  @override
  void initState() {
    super.initState();

    obscure = widget.obscureText;

    _controller.addListener(_controllerChangeListener);

    if (widget.vm.value != null) {
      _controller.text = widget.vm.value!;
    }
  }

  void _controllerChangeListener() {
    final text = _controller.text;
    final skip = widget.vm.value == null && text.isEmpty;
    if (widget.vm.value != text && !skip) {
      widget.vm.onChangedSync(text);
    }
  }

  @override
  void didUpdateWidget(InputFormField oldWidget) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final text = widget.vm.value ?? '';
      if (_controller.text != text) {
        _controller.value = TextEditingValue(
          text: text,
          selection: TextSelection.fromPosition(
            TextPosition(offset: text.length),
          ),
        );
      }
    });

    super.didUpdateWidget(oldWidget);
  }

  void toggleObscure() {
    setState(() => obscure = !obscure);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
