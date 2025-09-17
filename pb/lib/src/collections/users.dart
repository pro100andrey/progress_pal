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
    this.deleteAvatar = false,
  });

  final String? name;
  final DateTime? birthdate;
  final bool deleteAvatar;

  @override
  Map<String, dynamic> toJson() => {
    'name': ?name,
    'birthdate': ?birthdate?.toUtc().toIso8601String(),
    if (deleteAvatar) 'avatar': null,
  };
}
