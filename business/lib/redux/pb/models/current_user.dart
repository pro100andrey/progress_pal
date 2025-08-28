import 'package:pocketbase/pocketbase.dart';

extension type CurrentUser(RecordModel user) {
  String get id => user.id;
  String get email => user.getStringValue('email');
  String get name => user.getStringValue('name');
  String get avatar => user.getStringValue('avatar');
}
