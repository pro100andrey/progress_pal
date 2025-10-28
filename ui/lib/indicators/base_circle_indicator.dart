import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BaseCircleIndicator extends StatelessWidget {
  const BaseCircleIndicator({
    this.size = 18,
    this.color,
    super.key,
  });

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = this.color ?? theme.colorScheme.primary;

    return LoadingAnimationWidget.threeArchedCircle(
      color: color,
      size: size,
    );
  }
}
