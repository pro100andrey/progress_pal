import 'package:pocketbase/pocketbase.dart';

extension type User(RecordModel user) {
  String get id => user.id;
  String get email => user.getStringValue('email');
  String get name => user.getStringValue('name');
  String get avatarFileName => user.getStringValue('avatar');
  String get collectionName => user.getStringValue('collectionName');
  String get avatarUrlPath =>
      '/api/files/$collectionName/${user.id}/$avatarFileName';
  bool get hasAvatar => avatarFileName.isNotEmpty;
  bool get isWriter => user.getStringValue('role') == 'writer';

  DateTime get createdAt => DateTime.parse(user.getStringValue('created'));
}
