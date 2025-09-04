import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../models/value_changed.dart';

class TextareaInput extends ShadTextareaFormField {
  TextareaInput({
    required this.vm,
    super.id,
    String? label,
    String? placeholder,
    super.key,
  }) : super(
         label: label != null ? Text(label) : null,
         placeholder: placeholder != null ? Text(placeholder) : null,
         initialValue: vm.value,
         onChanged: vm.onChanged,
         validator: vm.validator,
       );

  final ValueChangedVm<String?> vm;
}
