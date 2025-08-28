import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../connectors/confirm_verification_page_connector.dart';
import '../connectors/forgot_password_page_connector.dart';
import '../connectors/home_page_connector.dart';
import '../connectors/log_in_page_connector.dart';
import '../connectors/registration_page_connector.dart';
import '../connectors/reset_password_page_connector.dart';

mixin NavigationServiceDelegate {
  bool get isLoggedIn;
  void needLogout();
}

final navigation = Navigation();

final _navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  Navigation() {
    NavigateAction.setNavigatorKey(_navigatorKey);
  }

  late final NavigationServiceDelegate _delegate;
  // ignore: avoid_setters_without_getters
  set delegate(NavigationServiceDelegate delegate) {
    _delegate = delegate;
  }

  GoRouter get router => _router;

  BuildContext get context => _navigatorKey.currentContext!;

  late final _router = GoRouter(
    navigatorKey: _navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePageConnector(),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LogInPageConnector(),
      ),
      GoRoute(
        path: '/auth/registration',
        builder: (context, state) => const RegistrationPageConnector(),
      ),
      GoRoute(
        path: '/auth/forgot-password',
        builder: (context, state) => const ForgotPasswordPageConnector(),
      ),
      GoRoute(
        path: '/auth/confirm-verification/:token',
        builder: (context, state) {
          final token = state.pathParameters['token']!;

          return ConfirmVerificationPageConnector(token: token);
        },
      ),
      GoRoute(
        path: '/auth/confirm-password-reset/:token',
        builder: (context, state) {
          final token = state.pathParameters['token']!;

          return ResetPasswordPageConnector(token: token);
        },
      ),
    ],

    redirect: (context, state) {
      final isLoggedIn = _delegate.isLoggedIn;
      final cr = CurrentRoute(state);

      switch ((isLoggedIn, cr)) {
        case (true, CurrentRoute(isNeedLogout: true)):
          _delegate.needLogout();
          return null;
        case (true, CurrentRoute(isAuth: true)):
          return '/home';
        case (false, CurrentRoute(isAuth: false)):
          return '/auth/login';
        case (true, CurrentRoute(isIndex: true)):
          return '/home';
      }

      return null;
    },
  );

  void goToForgotPassword() => router.go('/auth/forgot-password');

  void goToRegistration() => router.go('/auth/registration');

  void goToLogIn() => router.go('/auth/login');

  void goToHome() => router.go('/home');

  void refresh() => router.refresh();
}

extension type CurrentRoute(GoRouterState state) {
  String get fullPath => state.uri.path;

  bool get isAuth => fullPath.startsWith('/auth/');

  bool get isNeedLogout =>
      fullPath.startsWith('/auth/confirm-verification/') ||
      fullPath.startsWith('/auth/confirm-password-reset/');

  bool get isIndex => fullPath == '/';
}
