import '../../models.dart';
import 'base_pb.dart';

class BodyStatsLogsCollection extends PBCollection
    with PBListMixin<BodyStatsLog> {
  const BodyStatsLogsCollection(super.pocketBase);

  @override
  String get collectionName => 'body_stats_logs';
}
