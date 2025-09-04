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

  static String m0(email) =>
      "A password reset link has been sent to ${email}. Please check your inbox.";

  static String m1(value) => "Minimum length ${value} symbols";

  static String m2(email) =>
      "A confirmation link has been sent to ${email}. Please check your inbox.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "_locale": MessageLookupByLibrary.simpleMessage("en"),
    "appName": MessageLookupByLibrary.simpleMessage("Progress Pal"),
    "areYouSure": MessageLookupByLibrary.simpleMessage("Are you sure?"),
    "backToLogIn": MessageLookupByLibrary.simpleMessage("Back to logIn"),
    "birthdate": MessageLookupByLibrary.simpleMessage("Birthdate"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm password"),
    "couldNotConnectToInternet": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t connect to internet.",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Create"),
    "createAWorkoutToGetStarted": MessageLookupByLibrary.simpleMessage(
      "Create a workout to get started.",
    ),
    "createExercise": MessageLookupByLibrary.simpleMessage("Create Exercise"),
    "creating": MessageLookupByLibrary.simpleMessage("Creating..."),
    "database": MessageLookupByLibrary.simpleMessage("Database"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Dismiss"),
    "done": MessageLookupByLibrary.simpleMessage("Done"),
    "dontHaveAccountYet": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account yet?",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "editProfile": MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "editProfileInstructions": MessageLookupByLibrary.simpleMessage(
      "Make changes to your profile here. Click save when you\'re done.",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emailInvalid": MessageLookupByLibrary.simpleMessage("Email is invalid"),
    "equipment": MessageLookupByLibrary.simpleMessage("Equipment"),
    "exerciseCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Exercise created successfully",
    ),
    "exerciseTitle": MessageLookupByLibrary.simpleMessage("Exercise Title"),
    "exercises": MessageLookupByLibrary.simpleMessage("Exercises"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "forgotPasswordEmailSent": m0,
    "forgotPasswordInstructions": MessageLookupByLibrary.simpleMessage(
      "Enter your email address to receive a password reset link.",
    ),
    "fullName": MessageLookupByLibrary.simpleMessage("Full name"),
    "instructions": MessageLookupByLibrary.simpleMessage("Instructions"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Invalid email"),
    "logIn": MessageLookupByLibrary.simpleMessage("Log in"),
    "loginInstructions": MessageLookupByLibrary.simpleMessage(
      "Log in to continue your journey.",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "logoutConfirmation": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to log out?",
    ),
    "minimumLengthSymbols": m1,
    "muscleGroup": MessageLookupByLibrary.simpleMessage("Muscle Group"),
    "mustContainAtLeastOneLowercase": MessageLookupByLibrary.simpleMessage(
      "Must contain at least one lowercase",
    ),
    "mustContainAtLeastOneUppercase": MessageLookupByLibrary.simpleMessage(
      "Must contain at least one uppercase",
    ),
    "my": MessageLookupByLibrary.simpleMessage("My"),
    "newExercise": MessageLookupByLibrary.simpleMessage("New Exercise"),
    "noExercises": MessageLookupByLibrary.simpleMessage("No Exercises"),
    "noWorkouts": MessageLookupByLibrary.simpleMessage("No Workouts"),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "pleaseCheckYorNetworkSettings": MessageLookupByLibrary.simpleMessage(
      "Please check yor network settings.",
    ),
    "progress": MessageLookupByLibrary.simpleMessage("Progress"),
    "recordingType": MessageLookupByLibrary.simpleMessage("Recording Type"),
    "registration": MessageLookupByLibrary.simpleMessage("Registration"),
    "registrationEmailSent": m2,
    "registrationInstructions": MessageLookupByLibrary.simpleMessage(
      "Please fill out the form below to create your account.",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset password"),
    "resetPasswordInstructions": MessageLookupByLibrary.simpleMessage(
      "Please enter your new password below.",
    ),
    "resetPasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Try logging in with your new password.",
    ),
    "rotateCcw": MessageLookupByLibrary.simpleMessage(
      "Rotate counterclockwise",
    ),
    "rotateCw": MessageLookupByLibrary.simpleMessage("Rotate clockwise"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "selectAnotherImage": MessageLookupByLibrary.simpleMessage(
      "Select another image",
    ),
    "sendResetLink": MessageLookupByLibrary.simpleMessage("Send Reset Link"),
    "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
    "signUp": MessageLookupByLibrary.simpleMessage("Sign up"),
    "successful": MessageLookupByLibrary.simpleMessage("Successful!"),
    "supportedImageFormats": MessageLookupByLibrary.simpleMessage(
      "Supported: jpg, jpeg, png",
    ),
    "thisFieldIsRequired": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "title": MessageLookupByLibrary.simpleMessage("title"),
    "typeYourInstructionsHere": MessageLookupByLibrary.simpleMessage(
      "Type your instructions here",
    ),
    "unknownError": MessageLookupByLibrary.simpleMessage(
      "Uh oh! Something went wrong.",
    ),
    "unsupportedImageFormat": MessageLookupByLibrary.simpleMessage(
      "Unsupported image format",
    ),
    "verificationSuccessful": MessageLookupByLibrary.simpleMessage(
      "Verification successful!",
    ),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome back!"),
    "workouts": MessageLookupByLibrary.simpleMessage("Workouts"),
    "youHaveNotCreatedAnyExercisesYet": MessageLookupByLibrary.simpleMessage(
      "You have not created any exercises yet.",
    ),
  };
}
