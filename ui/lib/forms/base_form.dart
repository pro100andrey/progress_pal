import 'package:flutter/widgets.dart';

/// A wrapper around Flutter's [Form] widget that manages a
/// [GlobalKey<FormState>] and provides utility methods for validation and
/// saving.
///
/// It also implements custom logic to correctly refresh validation errors
/// when the application's locale changes.
class BaseForm extends StatefulWidget {
  const BaseForm({
    required this.builder,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    super.key,
  });

  /// A function that builds the form's content. It receives the [BuildContext]
  /// and the [BaseFormState] instance, allowing form controls to interact
  /// with the form's validation logic (e.g., calling validateAndSave).
  final Widget Function(BuildContext context, BaseFormState state) builder;

  @override
  State<BaseForm> createState() => BaseFormState();

  /// Controls how and when form fields are automatically validated.
  /// Defaults to [AutovalidateMode.disabled].
  final AutovalidateMode autovalidateMode;
}

class BaseFormState extends State<BaseForm> {
  /// The global key used to uniquely identify the [Form] and allow
  /// validation and saving operations.
  final _formKey = GlobalKey<FormState>();

  /// Stores the last known application [Locale]. Used to detect changes
  /// in the application's language settings.
  Locale? _locale;

  /// A flag indicating whether validation has been explicitly attempted
  /// (by user action or button press) or if the form is in
  /// [AutovalidateMode.always] mode. This is essential for conditionally
  /// refreshing localized errors.
  bool _didValidate = false;

  @override
  void initState() {
    super.initState();

    // Initialize _didValidate to true if the mode is set to always,
    // as errors should be visible from the start.
    _didValidate = widget.autovalidateMode == AutovalidateMode.always;
  }

  @override
  void didUpdateWidget(covariant BaseForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    final currentLocale = Localizations.localeOf(context);

    // Check if the application's locale has changed.
    if (_locale != currentLocale) {
      _locale = currentLocale;

      // Only refresh validation errors if validation has already been
      // attempted. This respects the [AutovalidateMode.disabled] setting
      // before the first interaction.
      if (_didValidate) {
        // Use a post-frame callback to ensure the form's content has been
        // rebuilt with the new locale before running the validator. This
        // ensures errors are translated correctly.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _formKey.currentState?.validate();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) => Form(
    autovalidateMode: widget.autovalidateMode,
    // Use [onChanged] to detect the user's first interaction with any field.
    onChanged: () {
      if (!_didValidate &&
          widget.autovalidateMode != AutovalidateMode.disabled) {
        // Set the flag to true to enable error visibility, effectively
        // implementing the start of [AutovalidateMode.onUserInteraction]
        // behavior.
        _didValidate = true;
      }
    },
    key: _formKey,
    child: widget.builder(context, this),
  );

  /// Validates all form fields and saves them if validation succeeds.
  ///
  /// Returns `true` if the form is valid and saved, `false` otherwise.
  bool validateAndSave() {
    // Explicitly set the flag to true to ensure errors are visible after
    // a manual submission attempt.
    if (!_didValidate) {
      _didValidate = true;
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      return true;
    }

    return false;
  }
}
