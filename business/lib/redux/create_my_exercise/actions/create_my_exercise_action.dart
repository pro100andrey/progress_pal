import 'package:async_redux/async_redux.dart';
import 'package:pb/collections.dart';
import 'package:pb/models.dart';

import '../../action_mixins/waiting_for.dart';
import '../../app_state.dart';
import '../../current_profile/current_profile_selectors.dart';
import '../../my_exercises_view/actions/insert_my_exercise_action.dart';
import '../create_my_exercise_selectors.dart';

class CreateMyExerciseAction extends ReduxAction<AppState> with BaseWrapError {
  @override
  Future<AppState?> reduce() async {
    final currentUser = selectCurrentProfile(state)!;
    final title = selectCreateMyExerciseTitle(state)!;
    final instructions = selectCreateMyExerciseInstructions(state);
    final muscleGroupIds = selectCreateMyExerciseMuscleGroupIds(state);
    final equipmentId = selectCreateMyExerciseEquipmentId(state)!;
    final recordingTypeId = selectCreateMyExerciseRecordingTypeId(state)!;

    final titleLanguageString = LanguageString({r'$': title});
    final instructionsLanguageString = instructions != null
        ? LanguageString({r'$': instructions})
        : null;

    final result = await getPB.x.exercises.create(
      body: CreateExerciseBody(
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

    return null;
  }
}
