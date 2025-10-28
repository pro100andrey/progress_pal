import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import '../button/language_menu_button.dart';
import '../models/language.dart';
import '../models/value_changed.dart';
import 'input_form_field.dart';

class MultiLanguageExerciseFormFiled extends StatefulWidget {
  const MultiLanguageExerciseFormFiled({required this.vm, super.key});

  final MultiLangValueChangedVm<String?> vm;

  @override
  State<MultiLanguageExerciseFormFiled> createState() =>
      _MultiLanguageExerciseFormFiledState();
}

class _MultiLanguageExerciseFormFiledState
    extends State<MultiLanguageExerciseFormFiled> {
  late LanguageVm _lang = widget.vm.defaultLanguage;
  final _values = <String, String?>{};
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _values.addAll(widget.vm.values ?? {});
    _updateControllerText();
  }

  void _updateControllerText() {
    final text = _values[_lang.locale] ?? '';

    if (_controller.text != text) {
      _controller.text = text;
    }
  }

  @override
  void dispose() {
    _values.clear();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => InputFormField(
    controller: _controller,
    label: Text(S.current.exerciseTitle),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    placeholder: Text(S.current.newExercise),
    keyboardType: TextInputType.text,
    onChanged: (text) {
      _values[_lang.locale] = text;
      widget.vm.onChangedSync(_values);
    },
    validator: (value) {
      final newValues = Map<String, String?>.from(_values);
      newValues[_lang.locale] = value;
      return widget.vm.validator?.call(newValues);
    },
    leading: LanguageMenuButton(
      showFlags: false,
      vm: ValueChangedWithItemsVm(
        value: _lang,
        items: widget.vm.supportedLanguages,
        onChanged: (lang) {
          setState(() {
            _lang = lang;
            _updateControllerText();
          });
        },
      ),
    ),
  );
}
