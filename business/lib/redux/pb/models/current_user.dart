import 'package:pocketbase/pocketbase.dart';

extension type CurrentUser(RecordModel user) {
  String get id => user.id;
  String get email => user.getStringValue('email');
  String get name => user.getStringValue('name');
  String get avatarFileName => user.getStringValue('avatar');
  String get collectionName => user.getStringValue('collectionName');
  String get avatarUrlPath =>
      '/api/files/$collectionName/${user.id}/$avatarFileName';
  bool get hasAvatar => avatarFileName.isNotEmpty;
}
