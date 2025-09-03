import 'package:pocketbase/pocketbase.dart';

extension type User(RecordModel record) {
  /// Returns the ID of the user.
  String get id => record.id;

  /// Returns the email of the user.
  String get email => record.getStringValue('email');

  /// Returns the name of the user.
  String get name => record.getStringValue('name');

  /// Returns the avatar file name of the user.
  String get avatarFileName => record.getStringValue('avatar');

  /// Returns the collection name of the user.
  String get collectionName => record.getStringValue('collectionName');

  /// Returns the avatar URL path of the user.
  String get avatarUrlPath =>
      '/api/files/$collectionName/${record.id}/$avatarFileName';

  /// Returns whether the user has an avatar.
  bool get hasAvatar => avatarFileName.isNotEmpty;

  /// Returns whether the user is a writer.
  bool get isWriter => record.getStringValue('role') == 'writer';

  /// Returns the creation date of the user.
  DateTime get created => DateTime.parse(record.getStringValue('created'));
}
