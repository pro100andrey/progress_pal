import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../models/value_changed.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    required this.vm,
    this.id = 'password',
    this.placeholder,
    this.leadingIcon,
    super.key,
  });

  final String id;
  final String? placeholder;
  final IconData? leadingIcon;
  final ValueChangedVm<String?> vm;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) => ShadInputFormField(
    id: widget.id,
    placeholder: Text(widget.placeholder ?? S.current.password),
    leading: Icon(widget.leadingIcon ?? LucideIcons.key100),
    trailing: ShadButton.ghost(
      width: 20,
      height: 20,
      padding: EdgeInsets.zero,
      onPressed: () => setState(() => obscure = !obscure),
      child: Icon(obscure ? LucideIcons.eyeOff200 : LucideIcons.eye200),
    ),
    keyboardType: TextInputType.visiblePassword,
    obscureText: obscure,
    autofillHints: const [AutofillHints.password],
    initialValue: widget.vm.value,
    onChanged: widget.vm.onChanged,
    validator: widget.vm.validator,
  );
}
