import 'package:flutter/material.dart';

class BaseCircleIndicator extends StatelessWidget {
  const BaseCircleIndicator({
    this.size = 16,
    this.color = Colors.greenAccent,
    this.strokeWidth,
    this.value,
    super.key,
  });

  final double size;
  final Color? color;
  final double? strokeWidth;
  final double? value;

  @override
  Widget build(BuildContext context) {
    final width = size;
    final height = size;

    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        value: value,
        color: color,
        strokeWidth: strokeWidth ?? 3,
      ),
    );
  }
}
