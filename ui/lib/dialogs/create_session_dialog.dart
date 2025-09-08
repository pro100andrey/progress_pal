import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:wheel_picker/wheel_picker.dart';

import '../popovers/base_popover.dart';

class CreateSessionDialog extends StatelessWidget {
  const CreateSessionDialog({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: LayoutBuilder(
      builder: (context, constraints) => ShadDialog(
        scrollable: false,
        constraints: BoxConstraints(
          minHeight: constraints.maxHeight,
          maxWidth: min(constraints.maxWidth, 1500),
        ),
        title: Text(DateTime.now().toString()),
        child: const Row(
          spacing: 16,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  TimeRange(),
                  Expanded(
                    child: ShadCard(
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 320,
              height: double.infinity,
              child: ShadCard(),
            ),
          ],
        ),
      ),
    ),
  );
}

class TimeRange extends StatelessWidget {
  const TimeRange({
    super.key,
  });

  @override
  Widget build(BuildContext context) => const Row(
    spacing: 16,
    children: [
      TimePicker(label: 'From:'),
      TimePicker(label: 'To:'),
    ],
  );
}

class TimePicker extends StatelessWidget {
  const TimePicker({
    required this.label,
    super.key,
  });

  final String label;

  @override
  Widget build(BuildContext context) => ActionsPopover(
    anchor: const ShadAnchorAuto(
      offset: Offset(0, 8),
      targetAnchor: Alignment.bottomRight,
    ),
    builder: (context, controller) => ShadCard(
      padding: EdgeInsets.zero,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            controller.toggle();
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Text(label),
                const Text('12:00'),
              ],
            ),
          ),
        ),
      ),
    ),
    actionsBuilder: (context, controller) => [
      const WheelPickerExample(),
    ],
  );
}

class WheelPickerExample extends StatefulWidget {
  const WheelPickerExample({super.key});

  @override
  State<WheelPickerExample> createState() => _WheelPickerExampleState();
}

class _WheelPickerExampleState extends State<WheelPickerExample> {
  final now = TimeOfDay.now();
  late final _hoursWheel = WheelPickerController(
    itemCount: 12,
    initialIndex: now.hour % 12,
  );
  late final _minutesWheel = WheelPickerController(
    itemCount: 60,
    initialIndex: now.minute,
    mounts: [_hoursWheel],
  );

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    final textStyle = theme.textTheme.h4.copyWith(
      height: 1.4,
      fontFeatures: const [FontFeature.tabularFigures()],
      textBaseline: TextBaseline.ideographic,
    );

    final wheelStyle = WheelPickerStyle(
      itemExtent: textStyle.fontSize! * textStyle.height!, // Text height
      squeeze: 1.25,
      diameterRatio: .8,
      surroundingOpacity: .25,
      magnification: 1.2,
    );

    Widget itemBuilder(BuildContext context, int index) =>
        Text('$index'.padLeft(2, '0'), style: textStyle);

    final timeWheels = <Widget>[
      for (final wheelController in [_hoursWheel, _minutesWheel])
        Expanded(
          child: WheelPicker(
            builder: itemBuilder,
            controller: wheelController,
            looping: wheelController == _minutesWheel,
            style: wheelStyle,
            selectedIndexColor: Colors.redAccent,
          ),
        ),
    ]..insert(1, Text(':', style: textStyle));

    final amPmWheel = Expanded(
      child: WheelPicker(
        itemCount: 2,
        builder: (context, index) =>
            Text(['AM', 'PM'][index], style: textStyle),
        initialIndex: (now.period == DayPeriod.am) ? 0 : 1,
        looping: false,
        style: wheelStyle.copyWith(
          shiftAnimationStyle: const WheelShiftAnimationStyle(
            duration: Duration(seconds: 1),
            curve: Curves.bounceOut,
          ),
        ),
      ),
    );

    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _centerBar(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  ...timeWheels,
                  const SizedBox(width: 6),
                  amPmWheel,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Don't forget to dispose the controllers at the end.
    _hoursWheel.dispose();
    _minutesWheel.dispose();
    super.dispose();
  }

  Widget _centerBar(BuildContext context) => Center(
    child: Container(
      height: 38,
      decoration: BoxDecoration(
        color: const Color(0xFFC3C9FA).withAlpha(26),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
