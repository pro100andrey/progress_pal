import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class ConfirmVerificationPage extends StatelessWidget {
  const ConfirmVerificationPage({required this.isWaiting, super.key});

  final bool isWaiting;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(S.current.title)),
    body: const Stack(
      children: [Center(child: Text('ConfirmVerificationPage Coming soon...'))],
    ),
  );
}
