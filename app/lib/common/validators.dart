import 'package:localization/generated/l10n.dart';
import 'package:pro_validator/pro_validator.dart';
import 'package:ui/models/language.dart';

import '../map/language.dart';

/// Validator for required fields.
Validator get requiredValidator => RequiredValidator(
  error: S.current.thisFieldIsRequired,
  ignoreEmptyValues: false,
);

/// Validator for Email fields.
MultiValidator get emailValidator => MultiValidator(
  validators: [
    requiredValidator,
    EmailValidator(error: S.current.invalidEmail),
  ],
);

/// Validator for Password fields.
MultiValidator get passwordValidator => MultiValidator(
  validators: [
    requiredValidator,
    MinLengthValidator(min: 8, error: S.current.minimumLengthSymbols(8)),
    HasUppercaseValidator(error: S.current.mustContainAtLeastOneUppercase),
    HasLowercaseValidator(error: S.current.mustContainAtLeastOneLowercase),
  ],
);

/// Validator for matching passwords.
MatchValidator get passwordsMatchValidator => MatchValidator(
  error: S.current.passwordsDoNotMatch,
);

/// Validator for name fields.
MultiValidator get nameValidator => MultiValidator(
  validators: [
    requiredValidator,
    MinLengthValidator(min: 2, error: S.current.minimumLengthSymbols(2)),
  ],
);

Validator get nonEmptyIterableValidator => NonEmptyIterableValidator(
  error: S.current.thisFieldRequiresAtLeastOneSelection,
);

LanguageMapTextValidator get languageMapTextValidator =>
    LanguageMapTextValidator(
      errorBuilder: (value) {
        final missingLangs = <String>[];

        for (final lang in mapSupportedLanguages) {
          final text = value?[lang.locale];

          if (text != null && text.isNotEmpty) {
            continue;
          }

          missingLangs.add(lang.title);
        }

        return S.current.requiredFieldMissingForLangs(missingLangs.join(', '));
      },
      supportedLanguages: mapSupportedLanguages,
    );

// Custom Validators

abstract class IterableValidator<T> extends Validator<Iterable<T>?> {
  const IterableValidator({required super.error});

  @override
  String? call(Iterable<T>? value) {
    if (value == null) {
      return null;
    }

    return value.isEmpty ? super(value) : null;
  }
}

class NonEmptyIterableValidator<T> extends IterableValidator<T> {
  const NonEmptyIterableValidator({required super.error});

  @override
  bool isValid(Iterable<T>? value) => value != null && value.isNotEmpty;
}

abstract class ValidatorBuilder<T> {
  const ValidatorBuilder({required this.errorBuilder});

  /// The error to display when the validation fails
  final String? Function(T)? errorBuilder;

  /// Checks the input against the given conditions
  bool isValid(T value);

  /// Call is a special function that makes a class callable
  /// returns null if the input is valid otherwise it returns the provided error
  String? call(T value) => isValid(value) ? null : errorBuilder?.call(value);
}

abstract class MapValidator<K, V> extends ValidatorBuilder<Map<K, V>?> {
  const MapValidator({required super.errorBuilder});

  @override
  String? call(Map<K, V>? value) {
    if (value == null) {
      return null;
    }

    return value.isEmpty ? super(value) : null;
  }
}

class LanguageMapTextValidator extends MapValidator<String, String?> {
  const LanguageMapTextValidator({
    required super.errorBuilder,
    this.supportedLanguages = const [],
  });

  final List<LanguageVm> supportedLanguages;

  @override
  bool isValid(Map<String, String?>? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    for (final lang in supportedLanguages) {
      final text = value[lang.locale];

      if (text != null && text.isNotEmpty) {
        continue;
      }

      return false;
    }

    return true;
  }
}
