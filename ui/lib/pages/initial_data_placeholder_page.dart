import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import '../indicators/base_circle_indicator.dart';

class InitialDataPlaceholderPage extends StatelessWidget {
  const InitialDataPlaceholderPage({
    required this.onRetry,
    required this.isWaiting,
    required this.isAvailable,
    super.key,
  });

  final VoidCallback onRetry;
  final bool isWaiting;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Builder(
      builder: (context) {
        if (isWaiting && !isAvailable) {
          return const Center(
            child: BaseCircleIndicator(size: 42),
          );
        }

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.current.errorRetrievingData,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: isWaiting ? null : onRetry,
                  child: Text(S.current.retry),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
