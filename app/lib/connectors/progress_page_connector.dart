import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/current_profile/current_profile_selectors.dart';
import 'package:business/redux/language/language_selectors.dart';
import 'package:business/redux/progress_view/actions/init_progress_view_action.dart';
import 'package:business/redux/progress_view/actions/set_selected_date_action.dart';
import 'package:business/redux/progress_view/progress_view_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/models/value_changed.dart';
import 'package:ui/pages/progress_page.dart';
import 'package:ui/selectors/date_tiime_line_selector.dart';
import 'package:ui/tabs/progress_tabs.dart';

import '../navigation/navigation.dart';

class ProgressPageConnector extends StatelessWidget {
  const ProgressPageConnector({
    required this.tab,
    required this.child,
    super.key,
  });

  final ProgressShellTab tab;
  final Widget child;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    shouldUpdateModel: selectCurrentProfileIsSet,
    onInit: (store) => store.dispatchAndWait(InitProgressViewAction()),
    vm: () => _Factory(this),
    builder: (context, vm) => ProgressPage(
      dateSelector: vm.dateSelector,
      tab: vm.tab,
      child: child,
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, ProgressPageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final selectedDate = selectProgressViewSelectedDate(state);
    final currentUser = selectCurrentProfile(state)!;
    final language = selectLanguage(state);

    return _Vm(
      dateSelector: DateTimeLineSelectorVm(
        locale: language.locale,
        firstDate: currentUser.createdDate,
        focusedDate: ValueChangedVm(
          value: selectedDate,
          onChanged: (date) =>
              dispatchAndWait(SetSelectedDateAction(date: date)),
        ),
      ),
      tab: ValueChangedVm(
        value: ProgressTab.values[connector.tab.index],
        onChanged: (value) {
          switch (value) {
            case ProgressTab.logs:
              navigation.goToLogs();
            case ProgressTab.bodyStats:
              navigation.goToBodyStats();
            case ProgressTab.notes:
              navigation.goToNotes();
          }
        },
      ),
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.dateSelector,
    required this.tab,
  });

  final DateTimeLineSelectorVm dateSelector;
  final ValueChangedVm<ProgressTab> tab;

  @override
  List<Object?> get props => [dateSelector, tab];
}
