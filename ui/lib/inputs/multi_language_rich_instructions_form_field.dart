import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:localization/generated/l10n.dart';

import '../button/language_menu_button.dart';
import '../models/language.dart';
import '../models/value_changed.dart';
import '../rich_text/rich_input_form_field.dart';

class MultiLanguageRichInstructionsFormField extends StatefulWidget {
  const MultiLanguageRichInstructionsFormField({required this.vm, super.key});

  final MultiLangValueChangedVm<Delta?> vm;

  @override
  State<MultiLanguageRichInstructionsFormField> createState() =>
      _MultiLanguageRichInstructionsFormFieldState();
}

class _MultiLanguageRichInstructionsFormFieldState
    extends State<MultiLanguageRichInstructionsFormField> {
  late LanguageVm _lang = widget.vm.defaultLanguage;

  /// The controller for the currently selected language.
  final _controllers = <String, QuillController>{};

  @override
  void initState() {
    super.initState();

    final controllersEntries = widget.vm.supportedLanguages.map((lang) {
      final delta = widget.vm.values?[lang.locale];

      final controller = delta != null
          ? QuillController(
              document: Document.fromDelta(delta),
              selection: const TextSelection.collapsed(offset: 0),
            )
          : QuillController.basic();

      return MapEntry(lang.locale, controller);
    });

    final controllers = Map.fromEntries(controllersEntries);

    _controllers.addAll(controllers);
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
    super.dispose();
  }

  QuillController get effectiveController => _controllers[_lang.locale]!;

  Map<String, Delta?> get _deltas => _controllers.map(
    (locale, controller) {
      final documentIsEmpty = controller.document.isEmpty();

      return MapEntry(
        locale,
        documentIsEmpty ? null : controller.document.toDelta(),
      );
    },
  );

  @override
  Widget build(BuildContext context) => RichInputFormField(
    label: Text(S.current.instructions),
    controller: effectiveController,
    onChanged: (document) {
      widget.vm.onChangedSync(_deltas);
    },
    validator: (delta) {
      final newValues = _deltas;
      newValues[_lang.locale] = delta;
      return widget.vm.validator?.call(newValues);
    },
    barLeading: LanguageMenuButton(
      showFlags: false,
      vm: ValueChangedWithItemsVm(
        value: _lang,
        items: widget.vm.supportedLanguages,
        onChanged: (lang) {
          setState(() {
            _lang = lang;
          });
        },
      ),
    ),
  );
}
