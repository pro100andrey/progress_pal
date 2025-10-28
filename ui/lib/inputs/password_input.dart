import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../models/value_changed.dart';
import 'input_form_field.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    required this.vm,
    this.placeholder,
    this.leadingIcon,
    super.key,
  });

  final String? placeholder;
  final IconData? leadingIcon;
  final ValueChangedVm<String?> vm;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) => InputFormField(
    placeholder: Text(widget.placeholder ?? S.current.password),
    leading: Icon(widget.leadingIcon ?? LucideIcons.key),
    trailing: IconButton(
      icon: Icon(
        obscure ? LucideIcons.eyeOff : LucideIcons.eye,
      ),
      onPressed: () => setState(() => obscure = !obscure),
    ),
    keyboardType: TextInputType.visiblePassword,
    obscureText: obscure,
    autofillHints: const [AutofillHints.password],
    initialValue: widget.vm.value,
    onChanged: widget.vm.onChanged,
    validator: widget.vm.validator,
    enabled: widget.vm.enabled,
  );
}
