import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ConfirmVerificationPage extends StatelessWidget {
  const ConfirmVerificationPage({
    required this.isWaiting,
    required this.success,
    required this.onPressedBackToLogin,
    super.key,
  });

  final bool isWaiting;
  final bool success;
  final VoidCallback onPressedBackToLogin;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Builder(
      builder: (context) {
        if (isWaiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (success) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                Text(
                  S.current.verificationSuccessful,
                  style: ShadTheme.of(context).textTheme.h2,
                ),

                TextButton(
                  onPressed: onPressedBackToLogin,
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
