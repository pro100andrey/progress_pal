import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models/equipment_type.dart';

class EquipmentItemVm extends Equatable {
  const EquipmentItemVm({
    required this.name,
    required this.type,
    required this.onPressed,
  });

  final String name;
  final EquipmentType type;
  final VoidCallback? onPressed;

  @override
  List<Object?> get props => [name, type, onPressed != null];
}

class EquipmentItem extends StatelessWidget {
  const EquipmentItem({required this.vm, super.key});

  final EquipmentItemVm vm;

  @override
  Widget build(BuildContext context) => Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        vm.type.image.image(width: 100, height: 100),
        Padding(
          padding: const EdgeInsets.all(2),
          child: Text(vm.name),
        ),
      ],
    ),
  );
}
