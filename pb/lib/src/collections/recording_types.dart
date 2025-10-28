import '../models/recording_type.dart';
import 'base_pb.dart';

class RecordingTypesCollection extends PBCollection
    with PBListMixin<RecordingType> {
  const RecordingTypesCollection(super.pocketBase);

  @override
  String get collectionName => 'recording_types';
}
