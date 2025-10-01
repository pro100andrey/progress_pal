import 'package:async_redux/async_redux.dart';
import 'package:pb/collections.dart';
import 'package:pb/models.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../action_mixins/waiting_for.dart';
import '../../app_state.dart';
import '../../my_exercises_view/actions/insert_my_exercise_action.dart';
import '../../session/session_selectors.dart';
import '../create_exercise_selectors.dart';

class CreateExerciseAction extends ReduxAction<AppState> with WaitingFor {
  @override
  Future<AppState?> reduce() async {
    final currentUser = selectSessionCurrentUser(state)!;
    final title = selectCreateExerciseTitle(state)!;
    final instructions = selectCreateExerciseInstructions(state);
    final muscleGroupIds = selectCreateExerciseMuscleGroupIds(state);
    final equipmentId = selectCreateExerciseEquipmentId(state)!;
    final recordingTypeId = selectCreateExerciseRecordingTypeId(state)!;

    final titleLanguageString = LanguageString({r'$': title});
    final instructionsLanguageString = instructions != null
        ? LanguageString({r'$': instructions})
        : null;

    final collection = ExercisesCollection(getPocketBase);

    try {
      final result = await collection.create(
        body: ExerciseBody(
          title: titleLanguageString,
          instructions: instructionsLanguageString,
          muscleGroupIds: muscleGroupIds.toList(growable: false),
          equipmentId: equipmentId,
          recordingTypeId: recordingTypeId,
          createdById: currentUser.id,
        ),
      );

      dispatchSync(
        InsertMyExerciseAction(exercise: result, atIndex: 0),
        notify: false,
      );
    } on ClientException catch (e) {
      throw UserException(null, reason: e.response['message']);
    }

    return null;
  }
}
