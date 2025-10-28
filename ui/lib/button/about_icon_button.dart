import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../generated/assets.gen.dart';
import '../utils/link_text_span.dart';

/// An about icon button used on the example's app app bar.
class AboutIconButton extends StatelessWidget {
  const AboutIconButton({super.key, this.color, this.useRootNavigator = true});

  /// The color used on the icon button.
  ///
  /// If null, default to Icon() class default color.
  final Color? color;

  /// Use root navigator?
  final bool useRootNavigator;

  @override
  Widget build(BuildContext context) => IconButton(
    icon: Icon(LucideIcons.info, color: color),
    onPressed: () async {
      final packageInfo = await PackageInfo.fromPlatform();

      if (!context.mounted) {
        return;
      }

      showAppAboutDialog(
        context,
        packageInfo: packageInfo,
        useRootNavigator: useRootNavigator,
      );
    },
  );
}

// This [showAppAboutDialog] function is based on the [AboutDialog] example
// that exist(ed) in the Flutter Gallery App.
void showAppAboutDialog(
  BuildContext context, {
  required PackageInfo packageInfo,
  required bool useRootNavigator,
}) {
  final theme = Theme.of(context);
  final aboutTextStyle = theme.textTheme.bodyLarge!;
  final footerStyle = theme.textTheme.bodySmall!;
  final linkStyle = theme.textTheme.bodyLarge!.copyWith(
    color: theme.colorScheme.tertiary,
  );

  final mediaSize = MediaQuery.sizeOf(context);
  final width = mediaSize.width;
  final height = mediaSize.height;

  final appVersion = '${packageInfo.version}+${packageInfo.buildNumber}';
  // Check if this is a Web-WASM build, Web-JS build or native VM build.
  // ignore: do_not_use_environment
  const isRunningWithWasm = bool.fromEnvironment(
    'dart.tool.dart2wasm',
  );
  const buildType = isRunningWithWasm
      ? 'WasmGC'
      : kIsWeb
      ? 'JS'
      : 'native VM';
  const flutterVersionNum = FlutterVersion.version ?? '';
  const flutterChannel = FlutterVersion.channel ?? '';
  const flutterVersion = '$flutterChannel $flutterVersionNum ($buildType)';

  showAboutDialog(
    context: context,
    applicationName: S.current.appName,
    applicationVersion: appVersion,
    useRootNavigator: useRootNavigator,
    applicationIcon: Assets.logo.withBg.svg(
      width: 64,
      height: 64,
    ),
    applicationLegalese:
        '${S.current.copyright}\n${S.current.author}\n${S.current.license}',
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  style: aboutTextStyle,
                  text: '${S.current.appDescription}\n\n',
                ),
                LinkTextSpan(
                  style: linkStyle,
                  uri: Uri.parse(
                    'https://github.com/pro100andrey/progress_pal',
                  ),
                  text: 'Github Repository',
                ),
                TextSpan(
                  style: aboutTextStyle,
                  text:
                      '. It also includes the source code '
                      'of this application.\n\n',
                ),
                TextSpan(
                  style: footerStyle,
                  text:
                      'Built with Flutter $flutterVersion, '
                      '$appVersion. '
                      'Media size (w:${width.toStringAsFixed(0)}, '
                      'h:${height.toStringAsFixed(0)})\n'
                      'kReleaseMode: $kReleaseMode '
                      'kProfileMode: $kProfileMode '
                      'kDebugMode: $kDebugMode.',
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
