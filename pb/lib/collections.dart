/// pb library
library;

import 'package:pocketbase/pocketbase.dart';

import 'src/collections/equipments.dart';
import 'src/collections/exercises.dart';
import 'src/collections/muscle_groups.dart';
import 'src/collections/recording_types.dart';

export 'src/collections/equipments.dart';
export 'src/collections/exercises.dart';
export 'src/collections/muscle_groups.dart';
export 'src/collections/recording_types.dart';

extension type PBCollections(PocketBase pb) {
  ExercisesCollection get exercises => ExercisesCollection(pb);
  EquipmentsCollection get equipments => EquipmentsCollection(pb);
  MuscleGroupsCollection get muscleGroups => MuscleGroupsCollection(pb);
  RecordingTypesCollection get recordingTypes => RecordingTypesCollection(pb);
}

extension PBCollectionsX on PocketBase {
  PBCollections get x => PBCollections(this);
}
