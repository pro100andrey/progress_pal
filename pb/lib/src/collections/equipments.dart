import '../models/equipment.dart';
import 'base_pb.dart';

class EquipmentsCollection extends PBCollection with PBListMixin<Equipment> {
  const EquipmentsCollection(super.pocketBase);

  @override
  String get collectionName => 'equipments';
}
