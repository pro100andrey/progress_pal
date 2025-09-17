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
