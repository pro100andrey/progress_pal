// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uk locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'uk';

  static String m0(email) =>
      "Посилання для скидання пароля надіслано на ${email}. Будь ласка, перевірте пошту.";

  static String m1(value) => "Мінімальна довжина — ${value} символів";

  static String m2(email) =>
      "Посилання для підтвердження надіслано на ${email}. Будь ласка, перевірте пошту.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "_locale": MessageLookupByLibrary.simpleMessage("uk"),
    "appName": MessageLookupByLibrary.simpleMessage("Progress Pal"),
    "areYouSure": MessageLookupByLibrary.simpleMessage("Ви впевнені?"),
    "backToLogIn": MessageLookupByLibrary.simpleMessage("Назад до входу"),
    "birthdate": MessageLookupByLibrary.simpleMessage("Дата народження"),
    "cancel": MessageLookupByLibrary.simpleMessage("Скасувати"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Підтвердьте пароль",
    ),
    "couldNotConnectToInternet": MessageLookupByLibrary.simpleMessage(
      "Не вдалося підключитися до інтернету.",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Створити"),
    "createAWorkoutToGetStarted": MessageLookupByLibrary.simpleMessage(
      "Створіть тренування, щоб почати.",
    ),
    "createExercise": MessageLookupByLibrary.simpleMessage("Створити вправу"),
    "creating": MessageLookupByLibrary.simpleMessage("Створення..."),
    "database": MessageLookupByLibrary.simpleMessage("База даних"),
    "delete": MessageLookupByLibrary.simpleMessage("Видалити"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Закрити"),
    "done": MessageLookupByLibrary.simpleMessage("Готово"),
    "dontHaveAccountYet": MessageLookupByLibrary.simpleMessage(
      "Ще не маєте облікового запису?",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("Редагувати"),
    "editProfile": MessageLookupByLibrary.simpleMessage("Редагувати профіль"),
    "editProfileInstructions": MessageLookupByLibrary.simpleMessage(
      "Внесіть зміни у свій профіль тут. Натисніть «Зберегти», коли закінчите.",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Електронна пошта"),
    "emailInvalid": MessageLookupByLibrary.simpleMessage(
      "Некоректна адреса електронної пошти",
    ),
    "equipment": MessageLookupByLibrary.simpleMessage("Обладнання"),
    "exerciseTitle": MessageLookupByLibrary.simpleMessage("Назва вправи"),
    "exercises": MessageLookupByLibrary.simpleMessage("Вправи"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Забули пароль?"),
    "forgotPasswordEmailSent": m0,
    "forgotPasswordInstructions": MessageLookupByLibrary.simpleMessage(
      "Введіть свою електронну адресу, щоб отримати посилання для скидання пароля.",
    ),
    "fullName": MessageLookupByLibrary.simpleMessage("Повне ім’я"),
    "instructions": MessageLookupByLibrary.simpleMessage("Інструкції"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Некоректна електронна пошта",
    ),
    "logIn": MessageLookupByLibrary.simpleMessage("Увійти"),
    "loginInstructions": MessageLookupByLibrary.simpleMessage(
      "Увійдіть, щоб продовжити свій шлях.",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Вийти"),
    "logoutConfirmation": MessageLookupByLibrary.simpleMessage(
      "Ви впевнені, що хочете вийти?",
    ),
    "minimumLengthSymbols": m1,
    "muscleGroup": MessageLookupByLibrary.simpleMessage("М’язова група"),
    "mustContainAtLeastOneLowercase": MessageLookupByLibrary.simpleMessage(
      "Має містити хоча б одну малу літеру",
    ),
    "mustContainAtLeastOneUppercase": MessageLookupByLibrary.simpleMessage(
      "Має містити хоча б одну велику літеру",
    ),
    "my": MessageLookupByLibrary.simpleMessage("Мої"),
    "newExercise": MessageLookupByLibrary.simpleMessage("Нова вправа"),
    "noExercises": MessageLookupByLibrary.simpleMessage("Немає вправ"),
    "noWorkouts": MessageLookupByLibrary.simpleMessage("Немає тренувань"),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Паролі не збігаються",
    ),
    "pleaseCheckYorNetworkSettings": MessageLookupByLibrary.simpleMessage(
      "Будь ласка, перевірте налаштування мережі.",
    ),
    "progress": MessageLookupByLibrary.simpleMessage("Прогрес"),
    "recordingType": MessageLookupByLibrary.simpleMessage("Тип запису"),
    "registration": MessageLookupByLibrary.simpleMessage("Реєстрація"),
    "registrationEmailSent": m2,
    "registrationInstructions": MessageLookupByLibrary.simpleMessage(
      "Будь ласка, заповніть форму нижче, щоб створити обліковий запис.",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Скинути"),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Скинути пароль"),
    "resetPasswordInstructions": MessageLookupByLibrary.simpleMessage(
      "Будь ласка, введіть новий пароль нижче.",
    ),
    "resetPasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Спробуйте увійти з новим паролем.",
    ),
    "rotateCcw": MessageLookupByLibrary.simpleMessage(
      "Повернути проти годинникової",
    ),
    "rotateCw": MessageLookupByLibrary.simpleMessage(
      "Повернути за годинниковою",
    ),
    "save": MessageLookupByLibrary.simpleMessage("Зберегти"),
    "selectAnotherImage": MessageLookupByLibrary.simpleMessage(
      "Вибрати інше зображення",
    ),
    "sendResetLink": MessageLookupByLibrary.simpleMessage(
      "Надіслати посилання",
    ),
    "signIn": MessageLookupByLibrary.simpleMessage("Увійти"),
    "signUp": MessageLookupByLibrary.simpleMessage("Зареєструватися"),
    "successful": MessageLookupByLibrary.simpleMessage("Успішно!"),
    "supportedImageFormats": MessageLookupByLibrary.simpleMessage(
      "Підтримуються: jpg, jpeg, png",
    ),
    "thisFieldIsRequired": MessageLookupByLibrary.simpleMessage(
      "Це поле є обов’язковим",
    ),
    "title": MessageLookupByLibrary.simpleMessage("Заголовок"),
    "typeYourInstructionsHere": MessageLookupByLibrary.simpleMessage(
      "Введіть свої інструкції тут",
    ),
    "unknownError": MessageLookupByLibrary.simpleMessage(
      "Ой! Щось пішло не так.",
    ),
    "unsupportedImageFormat": MessageLookupByLibrary.simpleMessage(
      "Непідтримуваний формат зображення",
    ),
    "verificationSuccessful": MessageLookupByLibrary.simpleMessage(
      "Підтвердження успішне!",
    ),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("З поверненням!"),
    "workouts": MessageLookupByLibrary.simpleMessage("Тренування"),
    "youHaveNotCreatedAnyExercisesYet": MessageLookupByLibrary.simpleMessage(
      "Ви ще не створили жодної вправи.",
    ),
  };
}
