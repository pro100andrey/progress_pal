import 'package:localization/generated/l10n.dart';

import 'select_input.dart';

class RecordingTypeInput extends SelectInput {
  RecordingTypeInput({
    required super.vm,
    super.minWidth,
    super.key,
  }) : super(
         id: 'record_type',
         label: S.current.recordingType,

         placeholder: 'Select a record type',
       );
}
