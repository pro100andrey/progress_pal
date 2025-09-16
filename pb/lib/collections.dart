/// pb library
library;

import 'package:pocketbase/pocketbase.dart';

import 'src/collections/body_stats_logs.dart';
import 'src/collections/equipments.dart';
import 'src/collections/exercises.dart';
import 'src/collections/muscle_groups.dart';
import 'src/collections/recording_types.dart';
import 'src/collections/users.dart';

export 'src/collections/body_stats_logs.dart';
export 'src/collections/equipments.dart';
export 'src/collections/exercises.dart';
export 'src/collections/muscle_groups.dart';
export 'src/collections/recording_types.dart';
export 'src/collections/users.dart';

extension type PBCollections(PocketBase pb) {
  ExercisesCollection get exercises => ExercisesCollection(pb);
  EquipmentsCollection get equipments => EquipmentsCollection(pb);
  MuscleGroupsCollection get muscleGroups => MuscleGroupsCollection(pb);
  RecordingTypesCollection get recordingTypes => RecordingTypesCollection(pb);
  BodyStatsLogsCollection get bodyStats => BodyStatsLogsCollection(pb);
  UsersCollection get users => UsersCollection(pb);
}

extension PBCollectionsX on PocketBase {
  PBCollections get x => PBCollections(this);
}
