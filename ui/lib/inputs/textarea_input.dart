import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../models/value_changed.dart';

class TextareaInput extends StatelessWidget {
  const TextareaInput({
    required this.vm,
    this.label,
    this.placeholder,
    super.key,
  });

  final ValueChangedVm<String?> vm;
  final String? placeholder;
  final String? label;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      if (label != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(label!, style: ShadTheme.of(context).textTheme.small),
          ),
        ),
      ShadTextarea(
        placeholder: placeholder != null ? Text(placeholder!) : null,
        initialValue: vm.value,
        onChanged: vm.onChanged,
      ),
    ],
  );
}
