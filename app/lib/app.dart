import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/session/session_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'connectors/top_level_page_connector.dart';
import 'navigation/navigation.dart';

class AppConnector extends StatefulWidget {
  const AppConnector({required this.store, super.key});

  final Store<AppState> store;

  @override
  State<AppConnector> createState() => _AppConnectorState();
}

class _AppConnectorState extends State<AppConnector>
    with NavigationServiceDelegate {
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
    builder: (context, vm) => ShadApp.router(
      routerConfig: navigation.router,
      themeMode: ThemeMode.dark,
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: ShadColorScheme.fromName(
          'zinc',
          brightness: Brightness.dark,
        ),
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) => ShadAppBuilder(
        child: TopLevelPageConnector(
          child: UserExceptionDialog<AppState>(
            onShowUserExceptionDialog: _showUserError,
            child: child!,
          ),
        ),
      ),
    ),
  );

  @override
  bool get isLoggedIn => selectSessionIsValid(widget.store.state);
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, AppConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() => _Vm(language: 0);
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({required this.language});

  final int language;

  @override
  List<Object?> get props => [language];
}

void _showUserError(
  BuildContext context,
  UserException userException,
  bool useLocalContext,
) {
  final theme = ShadTheme.of(context);
  final message = userException.message ?? S.current.unknownError;

  ShadToaster.of(context).show(
    ShadToast.destructive(
      title: Text(message),
      description: userException.reason == null
          ? null
          : Text(userException.reason!),
      action: ShadButton.destructive(
        decoration: ShadDecoration(
          border: ShadBorder.all(
            color: theme.colorScheme.destructiveForeground,
            width: 1,
          ),
        ),
        onPressed: () => ShadToaster.of(context).hide(),
        child: Text(S.current.dismiss),
      ),
    ),
  );
}
