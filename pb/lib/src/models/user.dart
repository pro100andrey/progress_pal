import 'package:pocketbase/pocketbase.dart';

/// Represents a user in the system.
extension type User(RecordModel record) implements RecordModel {
  /// Returns the email of the user.
  String get email => record.getStringValue('email');

  /// Returns the name of the user.
  String get name => record.getStringValue('name');

  DateTime get birthdate => DateTime.parse(record.getStringValue('birthdate'));

  /// Returns the avatar file name of the user.
  String get avatarFileName => record.getStringValue('avatar');

  /// Returns the avatar URL path of the user.
  String get avatarUrlPath =>
      '/api/files/$collectionName/${record.id}/$avatarFileName';

  /// Returns whether the user has an avatar.
  bool get hasAvatar => avatarFileName.isNotEmpty;

  /// Returns whether the user is a writer.
  bool get isWriter => record.get<String>('role') == 'writer';

  /// Returns the creation date of the user.
  DateTime get createdDate => DateTime.parse(get<String>('created'));
}
