import 'dart:io';

import 'package:seeder/seeder.dart';

Future<void> main(List<String> args) async {
  final exitCode = await run(args);

  exit(exitCode);
}
