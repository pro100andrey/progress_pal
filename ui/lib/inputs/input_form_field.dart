import 'package:flutter/material.dart';

class InputFormField extends StatelessWidget {
  const InputFormField({
    this.label,
    this.placeholder,
    this.leading,
    this.trailing,
    this.keyboardType,
    this.autofillHints,
    this.groupId = EditableText,
    this.initialValue,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.validator,
    this.controller,
    this.focusNode,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    super.key,
  });

  final Widget? label;
  final Widget? placeholder;
  final Widget? leading;
  final Widget? trailing;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  final Object groupId;
  final String? initialValue;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final ValueChanged<String?>? onChanged;
  final VoidCallback? onTap;
  final FormFieldValidator<String?>? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FloatingLabelBehavior floatingLabelBehavior;

  @override
  Widget build(BuildContext context) => TextFormField(
    groupId: groupId,
    controller: controller,
    decoration: InputDecoration(
      floatingLabelBehavior: floatingLabelBehavior,
      label: label,
      hint: placeholder,
      prefixIcon: leading,
      suffixIcon: trailing,
    ),
    readOnly: readOnly,
    keyboardType: keyboardType,
    autofillHints: autofillHints,
    initialValue: initialValue,
    onTap: onTap,
    validator: validator,
    enabled: enabled,
    obscureText: obscureText,
    onChanged: (value) {
      final resultText = value.isEmpty ? null : value;

      onChanged?.call(resultText);
    },
  );
}
