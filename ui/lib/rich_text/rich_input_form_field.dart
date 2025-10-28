import 'package:dart_quill_delta/dart_quill_delta.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'rich_input.dart';
import 'rich_input_bar.dart';

class RichInputFormField extends FormField<Delta> {
  RichInputFormField({
    super.key,
    super.onSaved,
    super.forceErrorText,
    super.autovalidateMode,
    this.controller,
    super.enabled,
    Widget? label,
    Widget? barLeading,
    super.onReset,
    Delta? initialValue,
    bool readOnly = false,
    String? Function(Delta?)? validator,
    void Function(Delta?)? onChanged,
    bool autofocus = false,
  }) : super(
         initialValue: controller != null
             ? controller.document.isEmpty()
                   ? null
                   : controller.document.toDelta()
             : initialValue,
         validator: validator == null ? null : (v) => validator(v),
         builder: (state) => RichInput(
           controller: controller,
           enabled: enabled,
           readOnly: readOnly,
           barBuilder: (context, controller) {
             if (readOnly) {
               return null;
             }
             return RichInputBar(
               enabled: enabled,
               controller: controller,
               leading: barLeading,
             );
           },
           initialValue: controller == null ? state.value : null,
           errorText: state.errorText,
           label: label,
           autofocus: autofocus,
           onChanged: (delta) {
             if (delta != state.value) {
               state.didChange(delta);
               onChanged?.call(delta);
             }
           },
         ),
       );

  final QuillController? controller;
}
