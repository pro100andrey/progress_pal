import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FormContainer extends StatelessWidget {
  const FormContainer({
    required this.child,
    this.centered = false,
    this.maxWidth = 320,
    super.key,
  });

  final Widget child;
  final bool centered;
  final double maxWidth;

  @override
  Widget build(BuildContext context) => Align(
    alignment: centered ? Alignment.center : Alignment.topCenter,
    child: SingleChildScrollView(
      child: ShadCard(
        width: maxWidth,
        child: child,
      ),
    ),
  );
}
