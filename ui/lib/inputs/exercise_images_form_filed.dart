import 'package:flutter/widgets.dart';
import 'package:localization/generated/l10n.dart';

import '../image/editor/image_editor.dart';
import '../image/images_form_filed.dart';
import '../image/model.dart';
import '../models/value_changed.dart';
import '../sortable_wrap/sortable_wrap.dart';

class ExerciseImagesFormFiled extends ImagesFormField {
  ExerciseImagesFormFiled({
    required this.vm,
    super.autofocus,
    super.key,
  }) : super(
         label: Text(S.current.images),
         initialValue: vm.value,
         onChanged: vm.onChanged,
         validator: vm.validator,
         maxImages: 3,
         editorConfig: ImageEditorConfig.square(
           maxImageSize: ImageVm.maxExerciseSize,
         ),
         reorderableOptions: ReorderableWrapOptions(isLongPressDraggable: true),
       );

  final ValueChangedVm<List<ImageVm>> vm;
}
