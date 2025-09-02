import 'package:localization/generated/l10n.dart';
import 'package:pro_validator/pro_validator.dart';

final requiredValidator = RequiredValidator(
  error: S.current.thisFieldIsRequired,
  ignoreEmptyValues: false,
);

final emailValidator = MultiValidator(
  validators: [
    requiredValidator,
    EmailValidator(error: S.current.invalidEmail),
  ],
);

final passwordValidator = MultiValidator(
  validators: [
    requiredValidator,
    MinLengthValidator(min: 8, error: S.current.minimumLengthSymbols(8)),
    HasUppercaseValidator(error: S.current.mustContainAtLeastOneUppercase),
    HasLowercaseValidator(error: S.current.mustContainAtLeastOneLowercase),
  ],
);

final passwordsMatchValidator = MatchValidator(
  error: S.current.passwordsDoNotMatch,
);

final nameValidator = MultiValidator(
  validators: [
    requiredValidator,
    MinLengthValidator(min: 2, error: S.current.minimumLengthSymbols(2)),
  ],
);
