import 'package:localization/generated/l10n.dart';
import 'package:pro_validator/pro_validator.dart';

/// Validator for required fields.
final requiredValidator = RequiredValidator(
  error: S.current.thisFieldIsRequired,
  ignoreEmptyValues: false,
);

/// Validator for Email fields.
final emailValidator = MultiValidator(
  validators: [
    requiredValidator,
    EmailValidator(error: S.current.invalidEmail),
  ],
);

/// Validator for Password fields.
final passwordValidator = MultiValidator(
  validators: [
    requiredValidator,
    MinLengthValidator(min: 8, error: S.current.minimumLengthSymbols(8)),
    HasUppercaseValidator(error: S.current.mustContainAtLeastOneUppercase),
    HasLowercaseValidator(error: S.current.mustContainAtLeastOneLowercase),
  ],
);

/// Validator for matching passwords.
final passwordsMatchValidator = MatchValidator(
  error: S.current.passwordsDoNotMatch,
);

/// Validator for name fields.
final nameValidator = MultiValidator(
  validators: [
    requiredValidator,
    MinLengthValidator(min: 2, error: S.current.minimumLengthSymbols(2)),
  ],
);

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

const nonEmptyIterableValidator = NonEmptyIterableValidator(
  error: 'This field requires at least one selection',
);
