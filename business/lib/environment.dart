enum EnvironmentType {
  development,
  production;

  bool get isDev => this == development;
  bool get isProd => this == production;
}

final class Environment {
  const Environment._({required this.pbUrl, required this.type});

  static const _pbUrlKey = 'PB_URL';

  static Future<Environment> prod() =>
      _load(EnvironmentType.production, fallbackUrl: 'https://prod.com');

  static Future<Environment> dev() =>
      _load(EnvironmentType.development, fallbackUrl: 'https://dev.com');

  static Future<Environment> _load(
    EnvironmentType type, {
    required String fallbackUrl,
  }) async {
    final env = _fromEnvironment(type);

    return env ?? Environment._(pbUrl: fallbackUrl, type: type);
  }

  static Environment? _fromEnvironment(EnvironmentType type) {
    // ignore: do_not_use_environment
    if (const bool.hasEnvironment(_pbUrlKey)) {
      // ignore: do_not_use_environment
      const pbUrl = String.fromEnvironment(_pbUrlKey);
      return Environment._(pbUrl: pbUrl, type: type);
    }

    return null;
  }

  final String pbUrl;
  final EnvironmentType type;
}
