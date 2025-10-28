// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Progress Pal`
  String get appName {
    return Intl.message('Progress Pal', name: 'appName', desc: '', args: []);
  }

  /// `Your personal fitness companion app.`
  String get appDescription {
    return Intl.message(
      'Your personal fitness companion app.',
      name: 'appDescription',
      desc: '',
      args: [],
    );
  }

  /// `©2025 Progress Pal`
  String get copyright {
    return Intl.message(
      '©2025 Progress Pal',
      name: 'copyright',
      desc: '',
      args: [],
    );
  }

  /// `Andriy Ivanov`
  String get author {
    return Intl.message('Andriy Ivanov', name: 'author', desc: '', args: []);
  }

  /// `Licensed under MIT License`
  String get license {
    return Intl.message(
      'Licensed under MIT License',
      name: 'license',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Log in`
  String get logIn {
    return Intl.message('Log in', name: 'logIn', desc: '', args: []);
  }

  /// `Sign in`
  String get signIn {
    return Intl.message('Sign in', name: 'signIn', desc: '', args: []);
  }

  /// `Back to logIn`
  String get backToLogIn {
    return Intl.message(
      'Back to logIn',
      name: 'backToLogIn',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get registration {
    return Intl.message(
      'Registration',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `Please fill out the form below to create your account.`
  String get registrationInstructions {
    return Intl.message(
      'Please fill out the form below to create your account.',
      name: 'registrationInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPassword {
    return Intl.message(
      'Reset password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your new password below.`
  String get resetPasswordInstructions {
    return Intl.message(
      'Please enter your new password below.',
      name: 'resetPasswordInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Email is invalid`
  String get emailInvalid {
    return Intl.message(
      'Email is invalid',
      name: 'emailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get thisFieldIsRequired {
    return Intl.message(
      'This field is required',
      name: 'thisFieldIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't connect to internet.`
  String get couldNotConnectToInternet {
    return Intl.message(
      'Couldn\'t connect to internet.',
      name: 'couldNotConnectToInternet',
      desc: '',
      args: [],
    );
  }

  /// `Please check yor network settings.`
  String get pleaseCheckYorNetworkSettings {
    return Intl.message(
      'Please check yor network settings.',
      name: 'pleaseCheckYorNetworkSettings',
      desc: '',
      args: [],
    );
  }

  /// `Minimum length {value} symbols`
  String minimumLengthSymbols(Object value) {
    return Intl.message(
      'Minimum length $value symbols',
      name: 'minimumLengthSymbols',
      desc: '',
      args: [value],
    );
  }

  /// `Must contain at least one lowercase`
  String get mustContainAtLeastOneLowercase {
    return Intl.message(
      'Must contain at least one lowercase',
      name: 'mustContainAtLeastOneLowercase',
      desc: '',
      args: [],
    );
  }

  /// `Must contain at least one uppercase`
  String get mustContainAtLeastOneUppercase {
    return Intl.message(
      'Must contain at least one uppercase',
      name: 'mustContainAtLeastOneUppercase',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullName {
    return Intl.message('Full name', name: 'fullName', desc: '', args: []);
  }

  /// `Don't have an account yet?`
  String get dontHaveAccountYet {
    return Intl.message(
      'Don\'t have an account yet?',
      name: 'dontHaveAccountYet',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back!`
  String get welcomeBack {
    return Intl.message(
      'Welcome back!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Log in to continue your journey.`
  String get loginInstructions {
    return Intl.message(
      'Log in to continue your journey.',
      name: 'loginInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address to receive a password reset link.`
  String get forgotPasswordInstructions {
    return Intl.message(
      'Enter your email address to receive a password reset link.',
      name: 'forgotPasswordInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Link`
  String get sendResetLink {
    return Intl.message(
      'Send Reset Link',
      name: 'sendResetLink',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message('Sign up', name: 'signUp', desc: '', args: []);
  }

  /// `Select another image`
  String get selectAnotherImage {
    return Intl.message(
      'Select another image',
      name: 'selectAnotherImage',
      desc: '',
      args: [],
    );
  }

  /// `Rotate clockwise`
  String get rotateCw {
    return Intl.message(
      'Rotate clockwise',
      name: 'rotateCw',
      desc: '',
      args: [],
    );
  }

  /// `Rotate counterclockwise`
  String get rotateCcw {
    return Intl.message(
      'Rotate counterclockwise',
      name: 'rotateCcw',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Successful!`
  String get successful {
    return Intl.message('Successful!', name: 'successful', desc: '', args: []);
  }

  /// `A confirmation link has been sent to {email}. Please check your inbox.`
  String registrationEmailSent(Object email) {
    return Intl.message(
      'A confirmation link has been sent to $email. Please check your inbox.',
      name: 'registrationEmailSent',
      desc: '',
      args: [email],
    );
  }

  /// `A password reset link has been sent to {email}. Please check your inbox.`
  String forgotPasswordEmailSent(Object email) {
    return Intl.message(
      'A password reset link has been sent to $email. Please check your inbox.',
      name: 'forgotPasswordEmailSent',
      desc: '',
      args: [email],
    );
  }

  /// `Verification successful!`
  String get verificationSuccessful {
    return Intl.message(
      'Verification successful!',
      name: 'verificationSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Try logging in with your new password.`
  String get resetPasswordSuccess {
    return Intl.message(
      'Try logging in with your new password.',
      name: 'resetPasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Birthdate`
  String get birthdate {
    return Intl.message('Birthdate', name: 'birthdate', desc: '', args: []);
  }

  /// `Log Out`
  String get logOut {
    return Intl.message('Log Out', name: 'logOut', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Make changes to your profile here. Click save when you're done.`
  String get editProfileInstructions {
    return Intl.message(
      'Make changes to your profile here. Click save when you\'re done.',
      name: 'editProfileInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get areYouSure {
    return Intl.message(
      'Are you sure?',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get logoutConfirmation {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'logoutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Uh oh! Something went wrong.`
  String get unknownError {
    return Intl.message(
      'Uh oh! Something went wrong.',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Dismiss`
  String get dismiss {
    return Intl.message('Dismiss', name: 'dismiss', desc: '', args: []);
  }

  /// `Unsupported image format`
  String get unsupportedImageFormat {
    return Intl.message(
      'Unsupported image format',
      name: 'unsupportedImageFormat',
      desc: '',
      args: [],
    );
  }

  /// `Supported: jpg, jpeg, png`
  String get supportedImageFormats {
    return Intl.message(
      'Supported: jpg, jpeg, png',
      name: 'supportedImageFormats',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progress {
    return Intl.message('Progress', name: 'progress', desc: '', args: []);
  }

  /// `Workouts`
  String get workouts {
    return Intl.message('Workouts', name: 'workouts', desc: '', args: []);
  }

  /// `Exercises`
  String get exercises {
    return Intl.message('Exercises', name: 'exercises', desc: '', args: []);
  }

  /// `My`
  String get my {
    return Intl.message('My', name: 'my', desc: '', args: []);
  }

  /// `Database`
  String get database {
    return Intl.message('Database', name: 'database', desc: '', args: []);
  }

  /// `Exercise Title`
  String get exerciseTitle {
    return Intl.message(
      'Exercise Title',
      name: 'exerciseTitle',
      desc: '',
      args: [],
    );
  }

  /// `Create Exercise`
  String get createExercise {
    return Intl.message(
      'Create Exercise',
      name: 'createExercise',
      desc: '',
      args: [],
    );
  }

  /// `Creating...`
  String get creating {
    return Intl.message('Creating...', name: 'creating', desc: '', args: []);
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `Muscle Group`
  String get muscleGroup {
    return Intl.message(
      'Muscle Group',
      name: 'muscleGroup',
      desc: '',
      args: [],
    );
  }

  /// `Equipment`
  String get equipment {
    return Intl.message('Equipment', name: 'equipment', desc: '', args: []);
  }

  /// `Recording Type`
  String get recordingType {
    return Intl.message(
      'Recording Type',
      name: 'recordingType',
      desc: '',
      args: [],
    );
  }

  /// `New Exercise`
  String get newExercise {
    return Intl.message(
      'New Exercise',
      name: 'newExercise',
      desc: '',
      args: [],
    );
  }

  /// `Instructions`
  String get instructions {
    return Intl.message(
      'Instructions',
      name: 'instructions',
      desc: '',
      args: [],
    );
  }

  /// `Type your instructions here`
  String get typeYourInstructionsHere {
    return Intl.message(
      'Type your instructions here',
      name: 'typeYourInstructionsHere',
      desc: '',
      args: [],
    );
  }

  /// `No Workouts`
  String get noWorkouts {
    return Intl.message('No Workouts', name: 'noWorkouts', desc: '', args: []);
  }

  /// `Create a workout to get started.`
  String get createAWorkoutToGetStarted {
    return Intl.message(
      'Create a workout to get started.',
      name: 'createAWorkoutToGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `No Exercises`
  String get noExercises {
    return Intl.message(
      'No Exercises',
      name: 'noExercises',
      desc: '',
      args: [],
    );
  }

  /// `You have not created any exercises yet.`
  String get youHaveNotCreatedAnyExercisesYet {
    return Intl.message(
      'You have not created any exercises yet.',
      name: 'youHaveNotCreatedAnyExercisesYet',
      desc: '',
      args: [],
    );
  }

  /// `Exercise created successfully`
  String get exerciseCreatedSuccessfully {
    return Intl.message(
      'Exercise created successfully',
      name: 'exerciseCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Logs`
  String get logs {
    return Intl.message('Logs', name: 'logs', desc: '', args: []);
  }

  /// `Body Stats`
  String get bodyStats {
    return Intl.message('Body Stats', name: 'bodyStats', desc: '', args: []);
  }

  /// `Notes`
  String get notes {
    return Intl.message('Notes', name: 'notes', desc: '', args: []);
  }

  /// `No Logs`
  String get noLogs {
    return Intl.message('No Logs', name: 'noLogs', desc: '', args: []);
  }

  /// `You don't have any logs for this day.`
  String get youDontHaveAnyLogsForThisDay {
    return Intl.message(
      'You don\'t have any logs for this day.',
      name: 'youDontHaveAnyLogsForThisDay',
      desc: '',
      args: [],
    );
  }

  /// `Add Session`
  String get addSession {
    return Intl.message('Add Session', name: 'addSession', desc: '', args: []);
  }

  /// `No Body Stats`
  String get noBodyStats {
    return Intl.message(
      'No Body Stats',
      name: 'noBodyStats',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any body stats for this day.`
  String get youDontHaveAnyBodyStatsForThisDay {
    return Intl.message(
      'You don\'t have any body stats for this day.',
      name: 'youDontHaveAnyBodyStatsForThisDay',
      desc: '',
      args: [],
    );
  }

  /// `Add Body Stat`
  String get addBodyStat {
    return Intl.message(
      'Add Body Stat',
      name: 'addBodyStat',
      desc: '',
      args: [],
    );
  }

  /// `No Notes`
  String get noNotes {
    return Intl.message('No Notes', name: 'noNotes', desc: '', args: []);
  }

  /// `You don't have any notes for this day.`
  String get youDontHaveAnyNotesForThisDay {
    return Intl.message(
      'You don\'t have any notes for this day.',
      name: 'youDontHaveAnyNotesForThisDay',
      desc: '',
      args: [],
    );
  }

  /// `Add Note`
  String get addNote {
    return Intl.message('Add Note', name: 'addNote', desc: '', args: []);
  }

  /// `Targeted Muscle Groups`
  String get targetedMuscleGroups {
    return Intl.message(
      'Targeted Muscle Groups',
      name: 'targetedMuscleGroups',
      desc: '',
      args: [],
    );
  }

  /// `Start typing here...`
  String get startTypingHere {
    return Intl.message(
      'Start typing here...',
      name: 'startTypingHere',
      desc: '',
      args: [],
    );
  }

  /// `Nothing to preview`
  String get nothingToPreview {
    return Intl.message(
      'Nothing to preview',
      name: 'nothingToPreview',
      desc: '',
      args: [],
    );
  }

  /// `Select a muscle group`
  String get selectAMuscleGroup {
    return Intl.message(
      'Select a muscle group',
      name: 'selectAMuscleGroup',
      desc: '',
      args: [],
    );
  }

  /// `Select an equipment`
  String get selectAnEquipment {
    return Intl.message(
      'Select an equipment',
      name: 'selectAnEquipment',
      desc: '',
      args: [],
    );
  }

  /// `This field requires at least one selection`
  String get thisFieldRequiresAtLeastOneSelection {
    return Intl.message(
      'This field requires at least one selection',
      name: 'thisFieldRequiresAtLeastOneSelection',
      desc: '',
      args: [],
    );
  }

  /// `Images`
  String get images {
    return Intl.message('Images', name: 'images', desc: '', args: []);
  }

  /// `It is necessary to fill in the field for the following languages: {languages}`
  String requiredFieldMissingForLangs(Object languages) {
    return Intl.message(
      'It is necessary to fill in the field for the following languages: $languages',
      name: 'requiredFieldMissingForLangs',
      desc: '',
      args: [languages],
    );
  }

  /// `Image Editor`
  String get imageEditor {
    return Intl.message(
      'Image Editor',
      name: 'imageEditor',
      desc: '',
      args: [],
    );
  }

  /// `System Mode`
  String get systemMode {
    return Intl.message('System Mode', name: 'systemMode', desc: '', args: []);
  }

  /// `Light Mode`
  String get lightMode {
    return Intl.message('Light Mode', name: 'lightMode', desc: '', args: []);
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: '', args: []);
  }

  /// `An error occurred while retrieving data.`
  String get errorRetrievingData {
    return Intl.message(
      'An error occurred while retrieving data.',
      name: 'errorRetrievingData',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Select a recording type`
  String get selectARecordingType {
    return Intl.message(
      'Select a recording type',
      name: 'selectARecordingType',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message('Filter', name: 'filter', desc: '', args: []);
  }

  /// `Exercise Filter`
  String get exerciseFilter {
    return Intl.message(
      'Exercise Filter',
      name: 'exerciseFilter',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
