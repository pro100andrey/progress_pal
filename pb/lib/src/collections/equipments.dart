import '../models/equipment.dart';
import 'base_pb.dart';

class EquipmentsCollection extends PBCollection<Equipment> with PBListMixin {
  const EquipmentsCollection(super.pocketBase);

  @override
  String get collectionName => 'equipments';
}
