import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models/muscle_group_type.dart';

class MuscleGroupItemVm extends Equatable {
  const MuscleGroupItemVm({
    required this.name,
    required this.type,
    required this.onPressed,
  });

  final String name;
  final MuscleGroupType type;
  final VoidCallback? onPressed;

  @override
  List<Object?> get props => [name, type, onPressed != null];
}

class MuscleGroupItem extends StatelessWidget {
  const MuscleGroupItem({required this.vm, super.key});

  final MuscleGroupItemVm vm;

  @override
  Widget build(BuildContext context) => Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        vm.type.image.svg(width: 100, height: 100),
        Padding(
          padding: const EdgeInsets.all(2),
          child: Text(vm.name),
        ),
      ],
    ),
  );
}
