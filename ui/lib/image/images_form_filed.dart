import 'package:flutter/widgets.dart';

import '../sortable_wrap/sortable_wrap.dart';
import 'editor/image_editor.dart';
import 'images_input.dart';
import 'model.dart';

class ImagesFormField extends FormField<List<ImageVm>> {
  ImagesFormField({
    required ImageEditorConfig editorConfig,
    super.onSaved,
    super.forceErrorText,
    super.enabled,
    super.autovalidateMode,
    super.onReset,
    this.controller,
    this.maxImages = 0,
    super.validator,
    bool autofocus = false,
    Widget? label,
    List<ImageVm>? initialValue,
    void Function(List<ImageVm>)? onChanged,

    ReorderableWrapOptions? reorderableOptions,
    super.key,
  }) : super(
         initialValue: controller != null ? controller.images : initialValue,
         builder: (state) => ImagesInput(
           autofocus: autofocus,
           label: label,
           editorConfig: editorConfig,
           initialValue: state.value,
           maxImages: maxImages,
           errorText: state.errorText,
           reorderableOptions: reorderableOptions,
           onChanged: (images) {
             state.didChange(images);
             if (onChanged != null) {
               onChanged(images);
             }
           },
         ),
       );
  final ImagesSelectorController? controller;
  final int maxImages;
}
