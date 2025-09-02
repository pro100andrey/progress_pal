import '../../models.dart';
import 'base_pb.dart';

class MuscleGroupsCollection extends PBCollection<MuscleGroup>
    with PBListMixin {
  const MuscleGroupsCollection(super.pocketBase);

  @override
  String get collectionName => 'muscle_groups';
}
