import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TextVersion extends StatelessWidget {
  const TextVersion({super.key});

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: PackageInfo.fromPlatform(),
    builder: (context, asyncSnapshot) {
      if (asyncSnapshot.hasData) {
        final packageInfo = asyncSnapshot.data!;
        return Text(
          '${packageInfo.version}+${packageInfo.buildNumber}',
          style: ShadTheme.of(context).textTheme.muted,
        );
      } else {
        return const SizedBox.shrink();
      }
    },
  );
}
