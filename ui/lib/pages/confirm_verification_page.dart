import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import '../indicators/base_circle_indicator.dart';

class ConfirmVerificationPage extends StatelessWidget {
  const ConfirmVerificationPage({
    required this.isWaiting,
    required this.success,
    required this.onBackToLoginPressed,
    super.key,
  });

  final bool isWaiting;
  final bool success;
  final VoidCallback onBackToLoginPressed;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Builder(
      builder: (context) {
        if (isWaiting) {
          return const Center(child: BaseCircleIndicator());
        } else if (success) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                Text(
                  S.current.verificationSuccessful,
                ),
                TextButton(
                  onPressed: onBackToLoginPressed,
                  child: Text(S.current.backToLogIn),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('Verification failed. Please try again.'),
          );
        }
      },
    ),
  );
}
