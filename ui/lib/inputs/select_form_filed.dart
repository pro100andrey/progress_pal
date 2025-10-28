import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SelectInputItem<T> extends Equatable {
  const SelectInputItem({
    required this.label,
    required this.data,
  });

  final String label;
  final T data;

  U cast<U>() => data as U;

  @override
  List<Object?> get props => [label];
}

extension SetSelectInputItemX on List<SelectInputItem> {
  List<SelectInputItem<U>> castItems<U>() => cast<SelectInputItem<U>>();
}

class SelectInputVm extends Equatable {
  const SelectInputVm({
    required this.initialValue,
    required this.items,
    required this.onSelect,
    this.validator,
  });

  final SelectInputItem? initialValue;
  final List<SelectInputItem> items;
  final String? Function(SelectInputItem?)? validator;
  final ValueChanged<SelectInputItem?> onSelect;

  @override
  List<Object?> get props => [items, validator != null];
}

class SelectMultipleInputVm extends Equatable {
  const SelectMultipleInputVm({
    required this.initialValues,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  final List<SelectInputItem>? initialValues;
  final List<SelectInputItem> items;
  final ValueChanged<List<SelectInputItem>> onChanged;
  final String? Function(List<SelectInputItem>?)? validator;

  @override
  List<Object?> get props => [items, validator != null];
}

class SelectMultipleFormField<T> extends StatelessWidget {
  const SelectMultipleFormField({super.key});

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class SelectFormField extends StatelessWidget {
  const SelectFormField({
    required this.items,
    this.label,
    this.placeholder,
    this.leading,
    this.trailing,
    this.initialValue,
    this.groupId = DropdownButton,
    this.enabled = true,
    this.onChanged,
    this.validator,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    super.key,
  });

  final Widget? label;
  final Widget? placeholder;
  final Widget? leading;
  final Widget? trailing;
  final List<SelectInputItem> items;
  final SelectInputItem? initialValue;
  final Object groupId;
  final bool enabled;
  final FloatingLabelBehavior floatingLabelBehavior;
  final ValueChanged<SelectInputItem?>? onChanged;
  final FormFieldValidator<SelectInputItem?>? validator;

  @override
  Widget build(BuildContext context) =>
      DropdownButtonFormField<SelectInputItem>(
        initialValue: initialValue,
        items: items
            .map(
              (item) => DropdownMenuItem<SelectInputItem>(
                value: item,
                child: Text(item.label),
              ),
            )
            .toList(growable: false),
        decoration: InputDecoration(
          floatingLabelBehavior: floatingLabelBehavior,
          label: label,
          hintText: (placeholder as Text?)?.data,
          prefixIcon: leading,
          suffixIcon: trailing,
        ),
        validator: validator,
        onChanged: enabled ? onChanged : null,
        isExpanded: true,
        icon: const Icon(LucideIcons.chevronsUpDown, size: 20),
      );
}

class MultiselectFormField extends StatefulWidget {
  const MultiselectFormField({
    required this.items,
    this.label,
    this.placeholder,
    this.leading,
    this.trailing,
    this.initialValue,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.enabled = true,
    this.onChanged,
    this.validator,
    this.selectTitle,
    super.key,
  });

  final Widget? label;
  final Widget? placeholder;
  final Widget? leading;
  final Widget? trailing;
  final List<SelectInputItem> items;
  final List<SelectInputItem>? initialValue;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Widget? selectTitle;
  final bool enabled;
  final String? Function(List<SelectInputItem>?)? validator;
  final ValueChanged<List<SelectInputItem>>? onChanged;

  @override
  State<MultiselectFormField> createState() => _MultiselectFormFieldState();
}

class _MultiselectFormFieldState extends State<MultiselectFormField> {
  final _focusNode = FocusNode();

  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _showMultiSelectDialog(
    BuildContext context,
    FormFieldState<List<SelectInputItem>> state,
  ) async {
    _focusNode.requestFocus();

    final selectedList = await showDialog<List<SelectInputItem>>(
      context: context,
      builder: (ctx) => _MultiSelectDialog(
        items: widget.items,
        initialSelected: state.value!,
        title: widget.selectTitle,
      ),
    );

    _focusNode.unfocus();

    if (selectedList != null) {
      state.didChange(selectedList);
      widget.onChanged?.call(selectedList);
    }
  }

  @override
  Widget build(BuildContext context) => FormField<List<SelectInputItem>>(
    initialValue: widget.initialValue,
    validator: widget.validator,
    enabled: widget.enabled,
    builder: (state) {
      final selected = state.value ?? [];
      final theme = Theme.of(context);

      return Focus(
        focusNode: _focusNode,
        canRequestFocus: widget.enabled,
        onFocusChange: (_) => setState(() {}),

        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
          child: GestureDetector(
            onTap: widget.enabled
                ? () => _showMultiSelectDialog(context, state)
                : null,

            child: InputDecorator(
              isFocused: _focusNode.hasFocus,
              isHovering: _isHovering,
              isEmpty: selected.isEmpty,
              decoration: InputDecoration(
                floatingLabelBehavior: widget.floatingLabelBehavior,
                label: widget.label,
                hint: widget.placeholder,
                prefixIcon: widget.leading,
                suffixIcon:
                    widget.trailing ??
                    const Icon(LucideIcons.chevronsUpDown, size: 20),
                errorText: state.errorText,
                enabled: widget.enabled,
              ),
              child: Builder(
                builder: (context) => Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: selected
                      .map(
                        (value) => DecoratedBox(
                          decoration: BoxDecoration(
                            color: theme.chipTheme.backgroundColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Text(
                              value.label,
                              // style: theme.chipTheme.labelStyle,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class _MultiSelectDialog extends StatefulWidget {
  const _MultiSelectDialog({
    required this.items,
    required this.initialSelected,
    this.title,
  });

  final List<SelectInputItem> items;
  final List<SelectInputItem> initialSelected;
  final Widget? title;

  @override
  State<_MultiSelectDialog> createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<_MultiSelectDialog> {
  late List<SelectInputItem> selected;

  @override
  void initState() {
    super.initState();
    selected = List.from(widget.initialSelected);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: widget.title,
    scrollable: true,
    constraints: const BoxConstraints(minWidth: 400),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widget.items.map((item) {
        final isSelected = selected.contains(item);
        return CheckboxListTile(
          title: Text(item.label),
          value: isSelected,
          onChanged: (checked) {
            setState(() {
              if (checked ?? false) {
                selected.add(item);
              } else {
                selected.remove(item);
              }
            });
          },
        );
      }).toList(),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(S.current.cancel),
      ),
      ElevatedButton(
        onPressed: () => Navigator.pop(context, selected),
        child: Text(S.current.ok),
      ),
    ],
  );
}
