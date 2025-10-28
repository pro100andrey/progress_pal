import 'package:equatable/equatable.dart';

import '../generated/assets.gen.dart';

class LanguageVm extends Equatable {
  const LanguageVm({
    required this.locale,
    required this.short,
    required this.title,
  });

  final String locale;
  final String short;
  final String title;

  SvgGenImage get flag => switch (locale) {
    'uk' => Assets.flags.ua,
    'en' => Assets.flags.gb,
    _ => throw Exception('Unsupported language locale: $locale'),
  };

  @override
  List<Object?> get props => [locale, short, title];
}
