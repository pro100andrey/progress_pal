import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'language.dart';

void printD(Object? v) => print;

typedef VoidCallbackVm = FutureOr Function();

class BaseValueChangedVm<T> extends Equatable {
  const BaseValueChangedVm({
    this.onChanged = printD,
    this.validator,
    this.enabled = true,
  });

  final bool enabled;
  final FutureOr Function(T value) onChanged;
  final FormFieldValidator<T>? validator;

  void onChangedSync(T value) {
    if (!_ifActionIsSync(onChanged)) {
      throw Exception(
        "Can't onChangedSync(${value.runtimeType}) "
        'because ${value.runtimeType} is async.',
      );
    }

    // ignore: discarded_futures
    onChanged(value);
  }

  Future<void> onChangedAsync(T value) async {
    if (_ifActionIsSync(onChanged)) {
      throw Exception(
        "Can't onChangedAsync(${value.runtimeType}) "
        'because ${value.runtimeType} is async.',
      );
    }

    await onChanged(value);
  }

  @override
  List<Object?> get props => [enabled];
}

bool _ifActionIsSync<T>(FutureOr Function(T) action) {
  //
  /// Note: action MUST check that it's NOT Future<void> Function(),
  /// because checking if it's void Function() doesn't work.
  final isSync = action is! Future<void> Function();

  return isSync;
}

class ValueChangedVm<T> extends BaseValueChangedVm<T> {
  const ValueChangedVm({
    required this.value,
    super.onChanged = printD,
    super.validator,
    super.enabled,
  });

  final T value;

  @override
  List<Object?> get props => [value, enabled, validator == null];
}

class ValueChangedWithItemsVm<T> extends BaseValueChangedVm<T> {
  const ValueChangedWithItemsVm({
    required this.value,
    super.onChanged,
    super.validator,
    super.enabled,

    this.items = const [],
  });

  final T value;
  final List<T> items;

  @override
  List<Object?> get props => super.props + items + [value, validator == null];
}

class MultiLangValueChangedVm<T> extends BaseValueChangedVm<Map<String, T?>> {
  const MultiLangValueChangedVm({
    required this.values,
    required this.supportedLanguages,
    required this.defaultLanguage,
    super.onChanged = printD,
    super.validator,
    super.enabled,
  });

  /// Map where the key is the language code (e.g., 'en', 'ru')
  /// and the value is the data (e.g., String, Delta).
  final Map<String, T?>? values;
  final List<LanguageVm> supportedLanguages;
  final LanguageVm defaultLanguage;

  /// Utility method to get the value for a specific language
  T? getValue(String langCode) => values?[langCode];

  @override
  List<Object?> get props => [
    values,
    enabled,
    validator == null,
  ];
}
