import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/language/language_selectors.dart';
import 'package:business/redux/models/supported_lagnuage.dart';
import 'package:business/redux/session/actions/clean_session_action.dart';
import 'package:business/redux/session/session_selectors.dart';
import 'package:business/redux/theme/theme_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:ui/theme/common.dart';
import 'package:ui/utils/localizations_delegates.dart';

import 'connectors/top_level_page_connector.dart';
import 'navigation/navigation.dart';

class AppConnector extends StatefulWidget {
  const AppConnector({required this.store, super.key});

  final Store<AppState> store;

  @override
  State<AppConnector> createState() => _AppConnectorState();
}

class _AppConnectorState extends State<AppConnector> with NavigationDelegate {
  @override
  void initState() {
    super.initState();
    navigation.delegate = this;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(widget),
    builder: (context, vm) => MaterialApp.router(
      key: ValueKey(vm.language.locale),
      debugShowCheckedModeBanner: false,
      routerConfig: navigation.router,
      themeMode: vm.mode,
      darkTheme: AppTheme.dark,
      theme: AppTheme.light,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale(vm.language.locale),
      builder: (context, child) => TopLevelPageConnector(
        child: UserExceptionDialog<AppState>(
          onShowUserExceptionDialog: _showUserError,
          child: child!,
        ),
      ),
    ),
  );

  AppState get state => widget.store.state;

  @override
  bool get isLoggedIn => selectSessionIsValid(state);

  @override
  void needLogout() => widget.store.dispatchSync(CleanSessionAction());
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, AppConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final language = selectLanguage(state);
    final theme = selectThemeMode(state);

    return _Vm(language: language, mode: theme);
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.language,
    required this.mode,
  });

  final SupportedLanguage language;
  final ThemeMode mode;

  @override
  List<Object?> get props => [language, mode];
}

void _showUserError(
  BuildContext context,
  UserException userException,
  bool useLocalContext,
) {
  final message = userException.message ?? S.current.unknownError;
  final reason = userException.reason;

  if (!userException.ifOpenDialog) {
    return;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      width: 500,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (reason != null) Text(reason),
        ],
      ),
    ),
  );
}
