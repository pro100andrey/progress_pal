import '../../models.dart';
import 'base_pb.dart';

class UsersCollection extends PBCollection
    with PBUpdateMixin<User, UpdateUserBody> {
  const UsersCollection(super.pocketBase);

  @override
  String get collectionName => 'users';
}

class UpdateUserBody extends PBToJson {
  const UpdateUserBody({
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
