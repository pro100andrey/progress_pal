import 'package:dart_quill_delta/dart_quill_delta.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import '../image/image_preview.dart';
import '../image/model.dart';
import '../items/equipment_item.dart';
import '../items/muscle_group_item.dart';
import '../rich_text/rich_text_preview.dart';

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
  final Delta instructions;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
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
                          style: Theme.of(context).textTheme.titleMedium,
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
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      EquipmentItem(vm: equipment),
                    ],
                  ),
                ],
              ),
              Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.instructions,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  RichTextPreview(delta: instructions),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
