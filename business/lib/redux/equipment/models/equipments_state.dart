import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pb/models.dart';

part 'equipments_state.freezed.dart';

@freezed
abstract class EquipmentsState with _$EquipmentsState {
  const factory EquipmentsState({
    @Default(IMapConst<String, Equipment>({})) IMap<String, Equipment> table,
    @Default(IListConst<String>([])) IList<String> view,
  }) = _EquipmentsState;
}
