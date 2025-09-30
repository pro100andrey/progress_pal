import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../image/image_preview.dart';
import '../image/model.dart';
import '../items/equipment_item.dart';
import '../items/muscle_group_item.dart';

class ExerciseDetailsPage extends StatelessWidget {
  const ExerciseDetailsPage({
    required this.title,
    required this.preview,
    required this.equipment,
    required this.muscleGroups,
    required this.instructions,
    super.key,
  });

  final String title;
  final ImageVm preview;
  final EquipmentItemVm equipment;
  final List<MuscleGroupItemVm> muscleGroups;
  final String instructions;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 400,
              child: ImagePreview(
                source: preview,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                cacheSize: const Size.square(1024),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Flexible(
                child: Column(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.targetedMuscleGroups,
                      style: ShadTheme.of(context).textTheme.h4,
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ...muscleGroups.map(
                          (e) => MuscleGroupItem(vm: e),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    S.current.equipment,
                    style: ShadTheme.of(context).textTheme.h4,
                  ),
                  EquipmentItem(vm: equipment),
                ],
              ),
            ],
          ),

          Text(
            instructions,
            style: ShadTheme.of(context).textTheme.p,
          ),
        ],
      ),
    ),
  );
}
