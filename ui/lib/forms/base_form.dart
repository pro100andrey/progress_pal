import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BaseForm extends StatefulWidget {
  const BaseForm({required this.builder, super.key});

  final Widget Function(BuildContext context, GlobalKey<ShadFormState> state)
  builder;

  @override
  State<BaseForm> createState() => _BaseFormState();
}

class _BaseFormState extends State<BaseForm> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) => ShadForm(
    key: formKey,
    child: widget.builder(context, formKey),
  );
}
