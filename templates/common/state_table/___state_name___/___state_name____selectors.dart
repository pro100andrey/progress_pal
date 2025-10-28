import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../app_state.dart';
import 'actions/retrieve____state_name____action.dart';

/// Returns waiting value
bool select___StateName___IsWaiting(AppState state) =>
    state.wait.isWaitingForType<Retrieve___StateName___Action>();

/// Returns [IMap<String, Object>] table
IMap<String, Object> select___StateName___Table(AppState state) =>
    state.___stateName___.table;

/// Return [IList<String>] view
IList<String> select___StateName___View(AppState state) =>
    state.___stateName___.view;

/// Returns [Object] value by id
Object select___StateName___ById(AppState state, {required String id}) =>
    select___StateName___Table(state)[id]!;
