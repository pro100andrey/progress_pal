import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../models/value_changed.dart';

class PasswordInput extends ShadInputFormField {
  PasswordInput({
    required this.vm,
    String? id,
    String? placeholder,
    IconData? leadingIcon,
    super.key,
  }) : super(
         id: id ?? 'password',
         placeholder: Text(placeholder ?? S.current.password),
         leading: Icon(leadingIcon ?? LucideIcons.key100),
         trailing: Builder(
           builder: (context) {
             var obscure = true;
             return StatefulBuilder(
               builder: (context, setState) => ShadButton(
                 width: 24,
                 height: 24,
                 padding: EdgeInsets.zero,
                 onPressed: () {
                   setState(() {
                     obscure = !obscure;
                   });
                 },
                 child: Icon(
                   obscure ? LucideIcons.eyeOff200 : LucideIcons.eye200,
                 ),
               ),
             );
           },
         ),
         keyboardType: TextInputType.visiblePassword,
         obscureText: true,
         autofillHints: const [AutofillHints.password],
         initialValue: vm.value,
         onChanged: vm.onChanged,
       );

  final ValueChangedVm<String?> vm;
}
