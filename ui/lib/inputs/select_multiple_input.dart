import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SelectMultipleInputItem extends Equatable {
  const SelectMultipleInputItem({
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

class SelectMultipleInputVm extends Equatable {
  const SelectMultipleInputVm({
    required this.initialValue,
    required this.items,
    this.validator,
  });

  final Set<SelectMultipleInputItem>? initialValue;
  final Set<SelectMultipleInputItem> items;
  final String? Function(Set<SelectMultipleInputItem>?)? validator;

  @override
  List<Object?> get props => [items, validator != null];
}

class SelectMultipleInput
    extends ShadSelectMultipleFormField<SelectMultipleInputItem> {
  SelectMultipleInput({
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
         label: label != null ? Text(label) : null,
         description: description != null ? Text(description) : null,
         placeholder: placeholder != null ? Text(placeholder) : null,
         validator: vm.validator,
         selectedOptionsBuilder: (context, values) => Wrap(
           spacing: 8,
           runSpacing: 4,
           children: values
               .map(
                 (value) => ShadBadge.outline(child: Text(value.label)),
               )
               .toList(growable: false),
         ),
         trailing: const Icon(LucideIcons.chevronsUpDown200),
         initialValue: vm.initialValue,
         onChanged: (values) {
           debugPrint('Selected values: $values');
         },
         options: vm.items.map(
           (item) => ShadOption(value: item, child: Text(item.label)),
         ),
       );

  final SelectMultipleInputVm vm;
}

Widget test() => ShadSelect<String>.multiple(
  selectedOptionsBuilder: (context, values) => Column(
    children: values.map(Text.new).toList(),
  ),
);
