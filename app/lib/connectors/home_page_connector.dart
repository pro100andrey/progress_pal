import 'package:async_redux/async_redux.dart';
import 'package:business/redux/actions/retrieve_initial_data_action.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/current_profile/actions/subscribe_current_profile_action.dart';
import 'package:business/redux/current_profile/current_profile_selectors.dart';
import 'package:business/redux/db_exercises_view/actions/retrieve_database_exercises_action.dart';
import 'package:business/redux/language/language_selectors.dart';
import 'package:business/redux/models/image_source.dart';
import 'package:business/redux/models/supported_lagnuage.dart';
import 'package:business/redux/my_exercises_view/actions/retrieve_my_exercises_action.dart';
import 'package:business/redux/session/actions/clean_session_action.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/image/model.dart';
import 'package:ui/pages/home_page.dart';
import 'package:ui/pages/initial_data_placeholder_page.dart';
import 'package:ui/tiles/profile_tile.dart';

import '../navigation/navigation.dart';
import 'dialogs/edit_profile_dialog_connector.dart';
import 'widgets/language_menu_button_connector.dart';
import 'widgets/theme_mode_icon_button_connector.dart';

class HomePageConnector extends StatelessWidget {
  const HomePageConnector({required this.child, required this.tab, super.key});

  final Widget child;
  final HomeShellTab tab;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    shouldUpdateModel: selectCurrentProfileIsSet,
    onInit: (store) => _onInit(store.dispatchAndWait),
    builder: (context, vm) {
      final showInitialDataPlaceholder =
          vm.initialDataIsWaiting || !vm.initialDataIsAvailable;

      return showInitialDataPlaceholder
          ? InitialDataPlaceholderPage(
              onRetry: () async {
                await _onInit(context.dispatchAndWait);
              },
              isWaiting: vm.initialDataIsWaiting,
              isAvailable: vm.initialDataIsAvailable,
            )
          : HomePage(
              dataIsWaiting: vm.dataIsWaiting,
              drawer: vm.drawer,
              languageMenuButton: const LanguageMenuButtonConnector(),
              editProfileDialog: const EditProfileDialogConnector(),
              themeModeIconButton: const ThemeModeIconButtonConnector(),
              child: child,
            );
    },
  );

  Future<void> _onInit(
    Future<ActionStatus> Function(ReduxAction<AppState>) dispatchAndWait,
  ) async {
    final result = await dispatchAndWait(RetrieveInitialDataAction());

    if (result.isCompletedOk) {
      await dispatchAndWait(SubscribeCurrentProfileAction());
    }
  }
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, HomePageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final myExercisesIsWaiting = isWaiting(RetrieveMyExercisesAction);
    final dbExercisesIsWaiting = isWaiting(RetrieveDBExercisesAction);
    final language = selectLanguage(state);
    final currentUser = selectCurrentProfile(state)!;
    final avatar = selectCurrentProfileAvatar(state);

    final initialDataIsWaiting = isWaiting(RetrieveInitialDataAction);
    final initialDataIsAvailable = selectRetrieveInitialDataIsAvailable(state);
    final dataIsWaiting = myExercisesIsWaiting || dbExercisesIsWaiting;
    final selectedItem = DrawerItem.values[connector.tab.index];

    return _Vm(
      drawer: AppDrawerVm(
        profile: ProfileTileVm(
          userName: currentUser.name,
          avatar: switch (avatar) {
            NetworkImageSource(:final url, :final name) => ImageVm.network(
              url: url,
              name: name,
            ),
            _ => const ImageVm.noImage(),
          },
        ),
        selectedItem: selectedItem,
        onProgressPressed: navigation.goToProgress,
        onWorkoutsPressed: navigation.goToWorkouts,
        onExercisesPressed: navigation.goToExercises,
        onLogOutPressed: () {
          dispatchSync(CleanSessionAction());
          navigation.refresh();
        },
      ),
      dataIsWaiting: dataIsWaiting,
      initialDataIsWaiting: initialDataIsWaiting,
      initialDataIsAvailable: initialDataIsAvailable,
      language: language,
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.dataIsWaiting,
    required this.initialDataIsWaiting,
    required this.initialDataIsAvailable,
    required this.drawer,
    required this.language,
  });

  final bool dataIsWaiting;
  final bool initialDataIsWaiting;
  final bool initialDataIsAvailable;
  final AppDrawerVm drawer;
  final SupportedLanguage language;

  @override
  List<Object?> get props => [
    dataIsWaiting,
    initialDataIsWaiting,
    initialDataIsAvailable,
    drawer,
    language,
  ];
}
