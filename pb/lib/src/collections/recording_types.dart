import '../models/recording_type.dart';
import 'base_pb.dart';

class RecordingTypesCollection extends PBCollection<RecordingType>
    with PBListMixin {
  const RecordingTypesCollection(super.pocketBase);

  @override
  String get collectionName => 'recording_types';
}
