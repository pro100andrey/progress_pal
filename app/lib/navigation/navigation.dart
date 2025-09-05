import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../connectors/confirm_verification_page_connector.dart';
import '../connectors/database_exercises_page_connector.dart';
import '../connectors/exercises_page_connector.dart';
import '../connectors/forgot_password_page_connector.dart';
import '../connectors/home_page_connector.dart';
import '../connectors/log_in_page_connector.dart';
import '../connectors/my_exercises_page_connector.dart';
import '../connectors/progress_page_connector.dart';
import '../connectors/registration_page_connector.dart';
import '../connectors/reset_password_page_connector.dart';
import '../connectors/workouts_page_connector.dart';

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
        builder: (context, state) => ConfirmVerificationPageConnector(
          token: state.pathParameters['token']!,
        ),
      ),
      GoRoute(
        path: '/auth/confirm-password-reset/:token',
        builder: (context, state) => ResetPasswordPageConnector(
          token: state.pathParameters['token']!,
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => HomePageConnector(
          tab: HomeShellTab.fromPath(state.uri.path),
          child: child,
        ),
        routes: [
          GoRoute(
            path: '/home/progress',
            builder: (context, state) => const ProgressPageConnector(),
          ),
          GoRoute(
            path: '/home/workouts',
            builder: (context, state) => const WorkoutsPageConnector(),
          ),
          ShellRoute(
            builder: (context, state, child) => ExercisesPageConnector(
              tab: ExercisesShellTab.fromPath(state.uri.path),
              child: child,
            ),
            routes: [
              GoRoute(
                path: '/home/exercises/my',
                builder: (context, state) => const MyExercisesConnector(),
              ),
              GoRoute(
                path: '/home/exercises/database',
                builder: (context, state) =>
                    const DatabaseExercisesPageConnector(),
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = _delegate.isLoggedIn;
      final cr = _CurrentRoute(state);

      const defaultHomeTab = '/home/progress';
      const defaultExercisesTab = '/home/exercises/my';

      switch ((isLoggedIn, cr)) {
        case (true, _CurrentRoute(isNeedLogOut: true)):
          _delegate.needLogout();
          return null;
        case (false, _CurrentRoute(isAuth: false)):
          return '/auth/login';
        case (true, _CurrentRoute(isAuth: true)):
        case (true, _CurrentRoute(isIndex: true)):
          return defaultHomeTab;
        case (true, _CurrentRoute(isExercises: true)):
          return defaultExercisesTab;
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

  /// Navigate to the my exercises tab.
  void goToMyExercises() => router.go('/home/exercises/my');

  /// Navigate to the database exercises tab.
  void goToDatabaseExercises() => router.go('/home/exercises/database');

  /// Refresh the route. Needs to be called for redirection to take effect.
  void refresh() => router.refresh();
}

/// Helper extension for extracting information from the current route.
extension type _CurrentRoute(GoRouterState state) {
  /// The full path of the current route.
  String get _fullPath => state.uri.path;

  /// Whether the current route is an authentication route.
  bool get isAuth => _fullPath.startsWith('/auth/');

  /// Whether the current route requires the user to log out.
  bool get isNeedLogOut =>
      _fullPath.startsWith('/auth/confirm-verification/') ||
      _fullPath.startsWith('/auth/confirm-password-reset/');

  /// Whether the current route is an exercises route.
  bool get isExercises => _fullPath == '/home/exercises';

  /// Whether the current route is the index route.
  bool get isIndex => _fullPath == '/';
}

enum HomeShellTab {
  progress('/home/progress'),
  workouts('/home/workouts'),
  exercises('/home/exercises');

  const HomeShellTab(this.value);

  factory HomeShellTab.fromPath(String path) => HomeShellTab.values.firstWhere(
    (tab) => path.startsWith(tab.value),
    orElse: () => throw Exception('Unknown home shell tab value: $path'),
  );

  final String value;
}

enum ExercisesShellTab {
  my('/home/exercises/my'),
  database('/home/exercises/database');

  const ExercisesShellTab(this.value);

  factory ExercisesShellTab.fromPath(String path) =>
      ExercisesShellTab.values.firstWhere(
        (tab) => path.startsWith(tab.value),
        orElse: () =>
            throw Exception('Unknown exercises shell tab value: $path'),
      );

  final String value;
}
