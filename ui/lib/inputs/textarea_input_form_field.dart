import 'package:flutter/material.dart';

import '../models/value_changed.dart';

class TextareaInputFormFiled extends StatelessWidget {
  const TextareaInputFormFiled({
    required this.vm,
    this.label,
    this.placeholder,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    super.key,
  });

  final ValueChangedVm<String?> vm;
  final Widget? label;
  final Widget? placeholder;
  final FloatingLabelBehavior floatingLabelBehavior;

  @override
  Widget build(BuildContext context) => TextFormField(
    minLines: 5,
    maxLength: 2000,
    maxLines: null,
    keyboardType: TextInputType.multiline,
    decoration: InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hint: placeholder,
      label: label,
    ),
  );
}
