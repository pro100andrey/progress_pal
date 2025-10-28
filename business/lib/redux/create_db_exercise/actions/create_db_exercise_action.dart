import 'package:async_redux/async_redux.dart';
import 'package:http/http.dart' as http;
import 'package:pb/collections.dart';
import 'package:pb/models.dart';

import '../../action_mixins/waiting_for.dart';
import '../../app_state.dart';
import '../../current_profile/current_profile_selectors.dart';
import '../../db_exercises_view/actions/insert_db_exercise_action.dart';
import '../../models/image_source.dart';
import '../create_db_exercise_selectors.dart';

class CreateDbExerciseAction extends ReduxAction<AppState> with BaseWrapError {
  @override
  Future<AppState?> reduce() async {
    final currentUser = selectCurrentProfile(state)!;
    final title = selectCreateDbExerciseTitle(state)!;
    final instructionsWithDelta = selectCreateDbExerciseInstructions(state)!;
    final muscleGroupIds = selectCreateDbExerciseMuscleGroupIds(state);
    final equipmentId = selectCreateDbExerciseEquipmentId(state)!;
    final recordingTypeId = selectCreateDbExerciseRecordingTypeId(state)!;
    final images = selectCreateDbExerciseImages(
      state,
    ).cast<MemoryImageSource>();
    
    final instructions = instructionsWithDelta
        .map(
          (key, delta) => MapEntry(
            key,
            delta != null ? delta.toJson() : '',
          ),
        )
        .unlock;

    final titleLanguageString = LanguageString(title.unlock);
    final instructionsLanguageString = LanguageString(instructions);

    final result = await getPB.x.exercises.create(
      body: CreateExerciseBody(
        title: titleLanguageString,
        instructions: instructionsLanguageString,
        muscleGroupIds: muscleGroupIds.toList(growable: false),
        equipmentId: equipmentId,
        recordingTypeId: recordingTypeId,
        createdById: currentUser.id,
        isSystem: true,
      ),
      files: [
        for (final image in images)
          http.MultipartFile.fromBytes(
            'preview',
            image.bytes,
            filename: image.name,
          ),
      ],
    );

    dispatchSync(
      InsertDbExerciseAction(exercise: result, atIndex: 0),
      notify: false,
    );

    return null;
  }
}
