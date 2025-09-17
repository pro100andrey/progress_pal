import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BaseCircleIndicator extends StatelessWidget {
  const BaseCircleIndicator({
    this.size = 24,
    this.color = Colors.greenAccent,
    super.key,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) =>
      LoadingAnimationWidget.threeArchedCircle(
        color: color,
        size: size,
      );
}
