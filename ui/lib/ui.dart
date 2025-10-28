import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
abstract class UI {
  /// Breakpoint for phone devices.
  static double phoneWidthBreakpoint = 600;

  /// Breakpoint for desktop devices.
  static double desktopWidthBreakpoint = 1024;

  /// Width of the menu in the responsive scaffold.
  static double menuWidth = 240;

  /// Determines if the device is a phone based on the screen width.
  static bool isPhone(BuildContext context) =>
      MediaQuery.of(context).size.width < phoneWidthBreakpoint;

  /// Returns the width of the rail based on the device type.
  static double railWidth(BuildContext context) => isPhone(context) ? 52 : 66;
}
