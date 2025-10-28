import 'package:dart_quill_delta/dart_quill_delta.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pb/models.dart';

import '../app_state.dart';
import '../models/image_source.dart';
import '../models/supported_lagnuage.dart';

/// Returns [IMap<String, Exercise>] table
IMap<String, Exercise> selectExercisesTable(AppState state) =>
    state.exercises.table;

/// Returns [Exercise] value by id
Exercise selectExerciseById(AppState state, {required String id}) =>
    selectExercisesTable(state)[id]!;

String selectExerciseLocalizedTitle(
  AppState state, {
  required String id,
  required SupportedLanguage language,
}) {
  final exercise = selectExerciseById(state, id: id);
  return exercise.title.getString(language.locale)!;
}

Delta selectExerciseLocalizedInstructions(
  AppState state, {
  required String id,
  required SupportedLanguage language,
}) {
  final exercise = selectExerciseById(state, id: id);
  final deltaJson = exercise.instructions!.getDelta(language.locale);
  return Delta.fromJson(deltaJson);
}

IList<NetworkImageSource> selectMyExercisesPreviews(
  AppState state, {
  required String id,
}) {
  final exercise = selectExerciseById(state, id: id);

  return exercise.previewUrlsPath.map((e) => getPB.baseURL + e).map((e) {
    final fileName = e.split('/').last;
    return NetworkImageSource(url: e, name: fileName);
  }).toIList();
}
