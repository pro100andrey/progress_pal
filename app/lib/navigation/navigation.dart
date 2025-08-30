import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../connectors/confirm_verification_page_connector.dart';
import '../connectors/exercises_page_connector.dart';
import '../connectors/forgot_password_page_connector.dart';
import '../connectors/home_page_connector.dart';
import '../connectors/log_in_page_connector.dart';
import '../connectors/progress_page_connector.dart';
import '../connectors/registration_page_connector.dart';
import '../connectors/reset_password_page_connector.dart';
import '../connectors/sheets/workouts_page_connector.dart';

/// A delegate for handling navigation events.
mixin NavigationDelegate {
  /// Whether the user is logged in.
  bool get isLoggedIn;

  /// Called when the user needs to log out.
  void needLogout();
}

/// The global navigation object.
final navigation = Navigation();

final _navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  Navigation() {
    // Need for showing error messages in a dialog
    // See https://asyncredux.com/flutter/basics/failed-actions#showing-error-messages-in-a-dialog
    NavigateAction.setNavigatorKey(_navigatorKey);
  }

  late final NavigationDelegate _delegate;
  // ignore: avoid_setters_without_getters
  set delegate(NavigationDelegate delegate) {
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
        path: '/auth/login',
        builder: (context, state) => const LogInPageConnector(),
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
      ShellRoute(
        builder: (context, state, child) {
          final cr = _CurrentRoute(state);

          return HomePageConnector(tab: cr.homeShellTab, child: child);
        },
        routes: [
          GoRoute(
            path: '/home/progress',
            builder: (context, state) => const ProgressPageConnector(),
          ),
          GoRoute(
            path: '/home/workouts',
            builder: (context, state) => const WorkoutsPageConnector(),
          ),
          GoRoute(
            path: '/home/exercises',
            builder: (context, state) => const ExercisesPageConnector(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = _delegate.isLoggedIn;
      final cr = _CurrentRoute(state);

      switch ((isLoggedIn, cr)) {
        case (true, _CurrentRoute(isNeedLogout: true)):
          _delegate.needLogout();
          return null;

        case (false, _CurrentRoute(isAuth: false)):
          return '/auth/login';
        case (true, _CurrentRoute(isAuth: true)):
        case (true, _CurrentRoute(isIndex: true)):
          return '/home/progress';
      }

      return null;
    },
  );

  /// Navigate to the forgot password page.
  void goToForgotPassword() => router.go('/auth/forgot-password');

  /// Navigate to the registration page.
  void goToRegistration() => router.go('/auth/registration');

  /// Navigate to the log in page.
  void goToLogIn() => router.go('/auth/login');

  /// Navigate to the progress page.
  void goToProgress() => router.go('/home/progress');

  /// Navigate to the workouts page.
  void goToWorkouts() => router.go('/home/workouts');

  /// Navigate to the exercises page.
  void goToExercises() => router.go('/home/exercises');

  /// Refresh the route. Needs to be called for redirection to take effect.
  void refresh() => router.refresh();
}

/// Helper extension for extracting information from the current route.
extension type _CurrentRoute(GoRouterState state) {
  String get _fullPath => state.uri.path;

  bool get isAuth => _fullPath.startsWith('/auth/');

  bool get isNeedLogout =>
      _fullPath.startsWith('/auth/confirm-verification/') ||
      _fullPath.startsWith('/auth/confirm-password-reset/');

  HomeShellTab get homeShellTab {
    if (_fullPath.startsWith('/home/progress')) {
      return HomeShellTab.progress;
    }
    if (_fullPath.startsWith('/home/workouts')) {
      return HomeShellTab.workouts;
    }
    if (_fullPath.startsWith('/home/exercises')) {
      return HomeShellTab.exercises;
    }
    throw Exception('Unknown home shell tab');
  }

  bool get isIndex => _fullPath == '/';
}

enum HomeShellTab {
  progress,
  workouts,
  exercises,
}
