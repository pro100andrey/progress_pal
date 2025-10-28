import '../../models.dart';
import 'base_pb.dart';

class MuscleGroupsCollection extends PBCollection
    with PBListMixin<MuscleGroup> {
  const MuscleGroupsCollection(super.pocketBase);

  @override
  String get collectionName => 'muscle_groups';
}
