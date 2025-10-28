import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../app_state.dart';
import '../../models/image_source.dart';

class SetImageAction extends ReduxAction<AppState> {
  SetImageAction({required this.images});

  final List<MemoryImageSource> images;

  @override
  AppState reduce() => state.copyWith.createDbExercise(images: images.lock);
}
