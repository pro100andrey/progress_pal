import 'package:pocketbase/pocketbase.dart';

/// Represents a user in the system.
extension type User(RecordModel record) implements RecordModel {
  /// Returns the email of the user.
  String get email => record.getStringValue('email');

  /// Returns the name of the user.
  String get name => record.getStringValue('name');

  DateTime get birthdate =>
      DateTime.parse(record.getStringValue('birthdate')).toLocal();

  /// Returns the avatar file name of the user.
  String get avatarFileName => record.getStringValue('avatar');

  /// Returns the avatar URL path of the user.
  String get avatarUrlPath =>
      '/api/files/$collectionName/${record.id}/$avatarFileName';

  /// Returns the full avatar URL of the user, or null if no avatar is set.
  String? avatarUrl(String baseUrl) =>
      hasAvatar ? baseUrl + avatarUrlPath : null;

  /// Returns whether the user has an avatar.
  bool get hasAvatar => avatarFileName.isNotEmpty;

  /// Returns the roles of the user.
  List<String> get roles => record.getListValue<String>('role');

  /// Returns whether the user is an admin.
  bool get isAdmin => roles.contains('admin');

  /// Returns whether the user is a writer.
  bool get isWriter => roles.contains('writer');

  /// Returns whether the user is a normal user (not admin or writer).
  bool get isNormalUser => !isAdmin && !isWriter;

  /// Returns the creation date of the user.
  DateTime get createdDate => DateTime.parse(get<String>('created')).toLocal();
}
