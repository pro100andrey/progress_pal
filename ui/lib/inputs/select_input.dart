import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
         label: label != null ? Text(label) : null,
         description: description != null ? Text(description) : null,
         placeholder: placeholder != null ? Text(placeholder) : null,
         validator: vm.validator,
         itemCount: vm.items.length,
         selectedOptionBuilder: (context, value) => Text(value.label),
         trailing: const Icon(LucideIcons.chevronsUpDown200),
         initialValue: vm.initialValue,
         onChanged: vm.onSelect,
         options: vm.items.map(
           (item) => ShadOption(value: item, child: Text(item.label)),
         ),
       );

  final SelectInputVm vm;
}

class SelectMultipleInputVm extends Equatable {
  const SelectMultipleInputVm({
    required this.initial,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  final List<SelectInputItem>? initial;
  final List<SelectInputItem> items;
  final ValueChanged<List<SelectInputItem>> onChanged;
  final String? Function(List<SelectInputItem>)? validator;

  @override
  List<Object?> get props => [items, validator != null];
}

class SelectMultipleInput extends ShadSelectMultipleFormField<SelectInputItem> {
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
         validator: (values) => vm.validator?.call(
           values!.toList(growable: false),
         ),
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
         initialValue: vm.initial?.toSet(),
         onChanged: (values) => vm.onChanged(values!.toList(growable: false)),
         options: vm.items.map(
           (item) => ShadOption(value: item, child: Text(item.label)),
         ),
       );

  final SelectMultipleInputVm vm;
}
