import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      child: ShadCard(
        width: 320,
        child: child,
      ),
    ),
  );
}
