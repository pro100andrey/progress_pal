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

  /// `en`
  String get _locale {
    return Intl.message('en', name: '_locale', desc: '', args: []);
  }

  /// `Progress Pal`
  String get appName {
    return Intl.message('Progress Pal', name: 'appName', desc: '', args: []);
  }

  /// `title`
  String get title {
    return Intl.message('title', name: 'title', desc: '', args: []);
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
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

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
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

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
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
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
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
