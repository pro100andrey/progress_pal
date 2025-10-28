import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class SetEquipmentAction extends ReduxAction<AppState> {
  SetEquipmentAction({required this.equipmentId});

  final String equipmentId;

  @override
  AppState reduce() =>
      state.copyWith.createDbExercise(equipmentId: equipmentId);
}
