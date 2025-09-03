import '../../models.dart';
import 'base_pb.dart';

class BodyStatsLogsCollection extends PBCollection<BodyStatsLog>
    with PBListMixin {
  const BodyStatsLogsCollection(super.pocketBase);

  @override
  String get collectionName => 'body_stats_logs';
}
