import 'package:async_redux/async_redux.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'confirm_verification/models/confirm_verification_state.dart';
import 'connectivity/models/connectivity_state.dart';
import 'create_db_exercise/models/create_db_exercise_state.dart';
import 'create_my_exercise/models/create_my_exercise_state.dart';
import 'current_profile/models/current_profile_state.dart';
import 'db_exercises_view/models/db_exercises_view_state.dart';
import 'edit_db_exercise/models/edit_db_exercise_state.dart';
import 'edit_my_exercise/models/edit_my_exercise_state.dart';
import 'edit_profile/models/edit_profile_state.dart';
import 'equipment/models/equipments_state.dart';
import 'exercises/models/exercises_state.dart';
import 'forgot_password/models/forgot_password_state.dart';
import 'language/models/language_state.dart';
import 'log_in/models/log_in_state.dart';
import 'muscle_groups/models/muscle_groups_state.dart';
import 'my_exercises_view/models/my_exercises_view_state.dart';
import 'progress_view/models/progress_view_state.dart';
import 'recording_types/models/recording_types_state.dart';
import 'registration/models/registration_state.dart';
import 'reset_password/models/reset_password_state.dart';
import 'session/models/session_state.dart';
import 'theme/models/theme_state.dart';

export '../service_locator.dart';

part 'app_state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    required ConnectivityState connectivity,
    required LanguageState language,
    required ThemeState theme,
    required LogInState logIn,
    required RegistrationState registration,
    required ForgotPasswordState forgotPassword,
    required ResetPasswordState resetPassword,
    required ConfirmVerificationState confirmVerification,
    required SessionState session,
    required MuscleGroupsState muscleGroups,
    required EquipmentsState equipments,
    required RecordingTypesState recordingTypes,
    required CreateMyExerciseState createMyExercise,
    required EditMyExerciseState editMyExercise,
    required CreateDbExerciseState createDbExercise,
    required EditDbExerciseState editDbExercise,
    required ExercisesState exercises,
    required MyExercisesViewState myExercisesView,
    required DbExercisesViewState dbExercisesView,
    required ProgressViewState progressView,
    required EditProfileState editProfile,
    required CurrentProfileState currentProfile,
    required Wait wait,
  }) = _AppState;

  factory AppState.initial() => const AppState(
    connectivity: ConnectivityState(),
    language: LanguageState(),
    theme: ThemeState(),
    logIn: LogInState(),
    registration: RegistrationState(),
    forgotPassword: ForgotPasswordState(),
    resetPassword: ResetPasswordState(),
    confirmVerification: ConfirmVerificationState(),
    session: SessionState(),
    muscleGroups: MuscleGroupsState(),
    equipments: EquipmentsState(),
    recordingTypes: RecordingTypesState(),
    createMyExercise: CreateMyExerciseState(),
    editMyExercise: EditMyExerciseState(),
    createDbExercise: CreateDbExerciseState(),
    editDbExercise: EditDbExerciseState(),
    exercises: ExercisesState(),
    myExercisesView: MyExercisesViewState(),
    dbExercisesView: DbExercisesViewState(),
    progressView: ProgressViewState(),
    editProfile: EditProfileState(),
    currentProfile: CurrentProfileState(),
    wait: Wait.empty,
  );
}
