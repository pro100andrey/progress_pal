import '../../models.dart';
import 'base_pb.dart';

class UsersCollection extends PBCollection<User>
    with
        PBListMixin,
        PBCreateMixin<User, UserBody>,
        PBUpdateMixin<User, UserBody>,
        PBDeleteMixin<User, UserBody> {
  const UsersCollection(super.pocketBase);

  @override
  String get collectionName => 'users';
}

class UserBody extends PBToJson {
  const UserBody({
    this.name,
    this.birthdate,
  });

  final String? name;
  final DateTime? birthdate;

  @override
  Map<String, dynamic> toJson() => {
    'name': ?name,
    'birthdate': ?birthdate?.toUtc().toIso8601String(),
  };
}
