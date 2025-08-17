import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.title,
    required this.onPressed,
    this.width = 174,
    this.height = 32,

    super.key,
  });

  final double width;
  final double height;
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => ShadButton(
    width: width,
    height: height,
    enabled: onPressed != null,
    onPressed: onPressed,
    child: Text(title),
  );
}
