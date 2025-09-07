import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/language/language_selectors.dart';
import 'package:business/redux/language/models/language_state.dart';
import 'package:business/redux/session/actions/clean_session_action.dart';
import 'package:business/redux/session/session_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ui/sizer/sizer.dart';

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
    builder: (context, vm) => Sizer(
      maxTabletWidth: 1023,
      builder: (context, orientation, screenType) => ShadApp.router(
        routerConfig: navigation.router,
        themeMode: ThemeMode.dark,
        darkTheme: ShadThemeData(
          brightness: Brightness.dark,
          colorScheme:
              ShadColorScheme.fromName(
                'zinc',
                brightness: Brightness.dark,
              ).copyWith(
                background: const Color(0xFF131316),
                card: const Color(0xFF161618),
                selection: const Color(0xFFE25D5D),
                popover: const Color(0xff161618),
              ),
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: Locale(vm.language.locale),
        builder: (context, child) => ShadAppBuilder(
          child: TopLevelPageConnector(
            child: UserExceptionDialog<AppState>(
              onShowUserExceptionDialog: _showUserError,
              child: child!,
            ),
          ),
        ),
      ),
    ),
  );

  @override
  bool get isLoggedIn => selectSessionIsValid(widget.store.state);

  @override
  void needLogout() => widget.store.dispatchSync(CleanSessionAction());
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, AppConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final language = selectLanguage(state);

    return _Vm(language: language);
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({required this.language});

  final SupportedLanguage language;

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
