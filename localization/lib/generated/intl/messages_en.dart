// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(value) => "Minimum length ${value} symbols";

  static String m1(email) =>
      "A confirmation link has been sent to ${email}. Please check your inbox.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "_locale": MessageLookupByLibrary.simpleMessage("en"),
    "backToLogIn": MessageLookupByLibrary.simpleMessage("Back to logIn"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm password"),
    "couldNotConnectToInternet": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t connect to internet.",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "done": MessageLookupByLibrary.simpleMessage("Done"),
    "dontHaveAccountYet": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account yet?",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emailInvalid": MessageLookupByLibrary.simpleMessage("Email is invalid"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "forgotPasswordInstructions": MessageLookupByLibrary.simpleMessage(
      "Enter your email address to receive a password reset link.",
    ),
    "fullName": MessageLookupByLibrary.simpleMessage("Full name"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Invalid email"),
    "logIn": MessageLookupByLibrary.simpleMessage("Log in"),
    "loginInstructions": MessageLookupByLibrary.simpleMessage(
      "Log in to continue your journey.",
    ),
    "minimumLengthSymbols": m0,
    "mustContainAtLeastOneLowercase": MessageLookupByLibrary.simpleMessage(
      "Must contain at least one lowercase",
    ),
    "mustContainAtLeastOneUppercase": MessageLookupByLibrary.simpleMessage(
      "Must contain at least one uppercase",
    ),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "pleaseCheckYorNetworkSettings": MessageLookupByLibrary.simpleMessage(
      "Please check yor network settings.",
    ),
    "registration": MessageLookupByLibrary.simpleMessage("Registration"),
    "registrationComplete": MessageLookupByLibrary.simpleMessage(
      "Registration complete",
    ),
    "registrationEmailSent": m1,
    "registrationInstructions": MessageLookupByLibrary.simpleMessage(
      "Please fill out the form below to create your account.",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset password"),
    "rotateCcw": MessageLookupByLibrary.simpleMessage(
      "Rotate counterclockwise",
    ),
    "rotateCw": MessageLookupByLibrary.simpleMessage("Rotate clockwise"),
    "selectAnotherImage": MessageLookupByLibrary.simpleMessage(
      "Select another image",
    ),
    "sendResetLink": MessageLookupByLibrary.simpleMessage("Send Reset Link"),
    "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
    "signUp": MessageLookupByLibrary.simpleMessage("Sign up"),
    "thisFieldIsRequired": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "title": MessageLookupByLibrary.simpleMessage("title"),
    "verificationSuccessful": MessageLookupByLibrary.simpleMessage(
      "Verification successful!",
    ),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome back!"),
  };
}
