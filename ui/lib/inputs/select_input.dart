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

class SelectInput extends ShadSelectFormField<SelectInputItem> {
  SelectInput({
    required this.vm,
    super.id,
    super.minWidth = 400,
    super.maxHeight = 300,
    String? placeholder,
    String? label,
    String? description,
    super.key,
  }) : super(
         anchor: ShadAnchor.center,
         label: label == null ? null : Text(label),
         description: description != null ? Text(description) : null,
         placeholder: placeholder != null ? Text(placeholder) : null,
         validator: vm.validator,
         itemCount: vm.items.length,
         selectedOptionBuilder: (context, value) => Text(value.label),
         trailing: const Icon(LucideIcons.chevronsUpDown200),
         initialValue: vm.initialValue,
         onChanged: (value) => value!.onSelect(),
         options: vm.items.map(
           (item) => ShadOption(value: item, child: Text(item.label)),
         ),
       );

  final SelectInputVm vm;
}
