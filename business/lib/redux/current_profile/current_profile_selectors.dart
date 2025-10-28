import 'package:pb/models.dart';

import '../app_state.dart';
import '../models/image_source.dart';

const String kUpdateProfileServiceKey = 'update_profile_service';

/// Returns the current user from the current profile state.
User? selectCurrentProfile(AppState state) => state.currentProfile.user;

/// Returns true if the current profile is set (i.e., not null).
bool selectCurrentProfileIsSet(AppState state) =>
    selectCurrentProfile(state) != null;

/// Returns the avatar URL of the current profile's user, or null if not set.
ImageSource selectCurrentProfileAvatar(AppState state) {
  final currentUser = selectCurrentProfile(state);
  final url = currentUser?.avatarUrl(getPB.baseURL);

  if (currentUser == null || url == null) {
    return const NoneImageSource();
  }

  final fileName = url.split('/').last;

  return ImageSource.network(url: url, name: fileName);
}
