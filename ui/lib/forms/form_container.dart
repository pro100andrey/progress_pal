import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  const FormContainer({
    required this.child,
    this.title,
    this.description,
    this.maxWidth = 320,
    this.footer,
    super.key,
  });

  final String? title;
  final String? description;
  final Widget child;
  final Widget? footer;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final titleWidget = title != null
        ? Text(
            title!,
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.start,
          )
        : null;

    final descriptionWidget = description != null
        ? Text(
            description!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.start,
          )
        : null;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    spacing: 24,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          ?titleWidget,
                          ?descriptionWidget,
                        ],
                      ),
                      child,
                    ],
                  ),
                ),
              ),
              if (footer != null) footer!,
            ],
          ),
        ),
      ),
    );
  }
}
