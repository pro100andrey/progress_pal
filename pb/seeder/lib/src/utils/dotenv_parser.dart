import 'package:dotenv/dotenv.dart';

import 'utils.dart';

 sealed class DotenvResult {
  const DotenvResult();
}

final class DotenvResultData extends DotenvResult {
  const DotenvResultData({
    required this.url,
    required this.username,
    required this.password,
  });

  final String url;
  final String username;
  final String password;
}

final class DotenvResultFileNotFound extends DotenvResult {
  const DotenvResultFileNotFound();
}

final class DotenvResultIsNotAFile extends DotenvResult {
  const DotenvResultIsNotAFile();
}

final class DotenvResultInvalid extends DotenvResult {
  const DotenvResultInvalid();
}

DotenvResult? tryParseDotenv(String? filePath) {
  if (filePath == null) {
    return null;
  }

  if (!isPathExists(filePath)) {
    return const DotenvResultFileNotFound();
  }

  if (!isFilePath(filePath)) {
    return const DotenvResultIsNotAFile();
  }

  final env = DotEnv()..load([filePath]);

  final url = env['PB_URL'];
  final username = env['PB_ADMIN_EMAIL'];
  final password = env['PB_ADMIN_PASSWORD'];

  if (url == null || username == null || password == null) {
    return const DotenvResultInvalid();
  }

  return DotenvResultData(
    url: url,
    username: username,
    password: password,
  );
}
