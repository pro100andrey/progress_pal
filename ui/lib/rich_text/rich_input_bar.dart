import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RichInputBar extends StatefulWidget {
  const RichInputBar({
    required this.controller,
    this.leading,
    this.enabled = true,
    super.key,
  });

  final QuillController controller;
  final Widget? leading;
  final bool enabled;

  @override
  State<RichInputBar> createState() => _RichInputBarState();
}

class _RichInputBarState extends State<RichInputBar> {
  @override
  Widget build(BuildContext context) {
    const baseOptions = QuillToolbarBaseButtonOptions(
      iconSize: 12,
    );

    final opacity = widget.enabled ? 1.0 : 0.5;
    final theme = Theme.of(context);
    const iconSize = 12.0;
    const dividerHeight = 16.0;

    return Theme(
      data: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: theme.colorScheme.tertiary,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(28, 28),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.center,
          ),
        ),
      ),
      child: AbsorbPointer(
        absorbing: !widget.enabled,
        child: Opacity(
          opacity: opacity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Wrap(
              spacing: 4,
              runSpacing: 2,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (widget.leading != null) ...[
                  widget.leading!,
                  const SizedBox(
                    height: dividerHeight,
                    child: VerticalDivider(),
                  ),
                ],
                QuillToolbarHistoryButton(
                  options: const QuillToolbarHistoryButtonOptions(
                    iconData: LucideIcons.undo,
                    iconSize: iconSize,
                  ),
                  isUndo: true,
                  controller: widget.controller,
                  baseOptions: baseOptions,
                ),
                QuillToolbarHistoryButton(
                  options: const QuillToolbarHistoryButtonOptions(
                    iconData: LucideIcons.redo,
                    iconSize: iconSize,
                  ),
                  isUndo: false,
                  controller: widget.controller,
                  baseOptions: baseOptions,
                ),
                const SizedBox(height: dividerHeight, child: VerticalDivider()),
                QuillToolbarToggleStyleButton(
                  options: const QuillToolbarToggleStyleButtonOptions(
                    iconData: LucideIcons.bold,
                    iconSize: iconSize,
                  ),
                  attribute: Attribute.bold,
                  controller: widget.controller,
                  baseOptions: baseOptions,
                ),
                QuillToolbarToggleStyleButton(
                  options: const QuillToolbarToggleStyleButtonOptions(
                    iconData: LucideIcons.italic,
                    iconSize: iconSize,
                  ),
                  attribute: Attribute.italic,
                  controller: widget.controller,
                  baseOptions: baseOptions,
                ),
                QuillToolbarClearFormatButton(
                  options: const QuillToolbarClearFormatButtonOptions(
                    iconData: LucideIcons.removeFormatting,
                    iconSize: iconSize,
                  ),
                  controller: widget.controller,
                  baseOptions: baseOptions,
                ),
                const SizedBox(height: dividerHeight, child: VerticalDivider()),
                QuillToolbarToggleStyleButton(
                  options: const QuillToolbarToggleStyleButtonOptions(
                    iconData: LucideIcons.textQuote,
                    iconSize: iconSize,
                  ),
                  controller: widget.controller,
                  attribute: Attribute.blockQuote,
                  baseOptions: baseOptions,
                ),
                QuillToolbarLinkStyleButton2(
                  options: const QuillToolbarLinkStyleButton2Options(
                    iconData: LucideIcons.link,
                    iconSize: iconSize,
                  ),
                  controller: widget.controller,
                  baseOptions: baseOptions,
                ),
                const SizedBox(height: dividerHeight, child: VerticalDivider()),
                QuillToolbarToggleStyleButton(
                  options: const QuillToolbarToggleStyleButtonOptions(
                    iconData: LucideIcons.listOrdered,
                    iconSize: iconSize,
                  ),
                  attribute: Attribute.ol,
                  controller: widget.controller,
                  baseOptions: baseOptions,
                ),
                QuillToolbarToggleStyleButton(
                  options: const QuillToolbarToggleStyleButtonOptions(
                    iconData: LucideIcons.list,
                    iconSize: iconSize,
                  ),
                  attribute: Attribute.ul,
                  controller: widget.controller,
                  baseOptions: baseOptions,
                ),
                const SizedBox(height: dividerHeight, child: VerticalDivider()),
                QuillToolbarSelectHeaderStyleButtons(
                  controller: widget.controller,
                  options: QuillToolbarSelectHeaderStyleButtonsOptions(
                    iconTheme: QuillIconTheme(
                      iconButtonSelectedData: IconButtonData(
                        color: theme.colorScheme.secondary,
                      ),
                      iconButtonUnselectedData: IconButtonData(
                        color: theme.iconTheme.color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
