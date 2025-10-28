import 'dart:async';

import 'package:pb/models.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../common/services/interface.dart';

// ignore: one_member_abstracts
abstract class ProfileUpdateServiceDriverInterface {
  void onUpdateProfile(User user);
  void onDeleteProfile(User user);
}

class ProfileUpdateService extends DisposableServiceInterface {
  ProfileUpdateService({
    required ProfileUpdateServiceDriverInterface driver,
    required PocketBase pb,
    required String userId,
  }) : _driver = driver,
       _pb = pb,
       _userId = userId;

  final ProfileUpdateServiceDriverInterface _driver;
  final PocketBase _pb;
  final String _userId;

  @override
  Future<void> start() async {
    unawaited(
      _pb.collection('users').subscribe(
        _userId,
        (e) {
          final record = e.record;

          if (e.action == 'delete' && record != null) {
            final user = User(record);
            _driver.onDeleteProfile(user);
            return;
          }

          if (e.action == 'update' && record != null) {
            final user = User(record);
            _driver.onUpdateProfile(user);
            return;
          }
        },
      ),
    );

    super.start();
  }

  @override
  Future<void> dispose() async {
    await _pb.collection('users').unsubscribe(_userId);
    super.dispose();
  }
}
