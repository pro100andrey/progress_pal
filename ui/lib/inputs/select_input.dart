import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SelectInputItem extends Equatable {
  const SelectInputItem({
    required this.label,
    required this.onSelect,
    this.validator,
  });

  final String label;
  final VoidCallback onSelect;
  final String? Function<T>(T?)? validator;

  @override
  List<Object?> get props => [label];
}

class SelectInputVm extends Equatable {
  const SelectInputVm({
    required this.initialValue,
    required this.items,
    this.validator,
  });

  final SelectInputItem? initialValue;
  final List<SelectInputItem> items;
  final String? Function(SelectInputItem?)? validator;

  @override
  List<Object?> get props => [items, validator != null];
}

class SelectInput extends StatelessWidget {
  const SelectInput({
    required this.vm,
    required this.placeholder,
    this.id,
    this.label,
    this.description,
    this.minWidth = 446,
    this.maxHeight = 200,
    super.key,
  });

  final SelectInputVm vm;
  final String placeholder;
  final String? label;
  final String? description;
  final String? id;
  final double minWidth;
  final double maxHeight;

  @override
  Widget build(BuildContext context) => ShadSelectFormField<SelectInputItem>(
    id: id,
    minWidth: minWidth,
    maxHeight: maxHeight,

    itemCount: vm.items.length,
    label: label == null ? null : Text(label!),
    description: description == null ? null : Text(description!),
    options: vm.items.map(
      (item) => ShadOption(value: item, child: Text(item.label)),
    ),
    selectedOptionBuilder: (context, value) => Text(value.label),
    initialValue: vm.initialValue,
    placeholder: Text(placeholder),
    validator: vm.validator,
    onChanged: (value) => value!.onSelect(),
    trailing: const Icon(LucideIcons.chevronsUpDown200),
  );
}
