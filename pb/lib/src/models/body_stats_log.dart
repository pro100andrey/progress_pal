import 'package:pocketbase/pocketbase.dart';

/// Represents a body stats log entry.
extension type BodyStatsLog(RecordModel log) implements RecordModel {
  /// Returns the user ID associated with the log.
  String get userId => log.getStringValue('user');

  /// Returns the date of the log.
  DateTime get date => DateTime.parse(log.getStringValue('date'));

  /// Returns the weight in kilograms.
  double get weight => log.get<double>('weight', 0);

  /// Returns the body fat percentage.
  double get bodyFat => log.get<double>('body_fat', 0);

  /// Returns the waist measurement in centimeters.
  double get waist => log.get<double>('waist', 0);

  /// Returns the chest measurement in centimeters.
  double get chest => log.get<double>('chest', 0);

  /// Returns the arms measurement in centimeters.
  double get arms => log.get<double>('arms', 0);

  /// Returns the forearms measurement in centimeters.
  double get forearms => log.get<double>('forearms', 0);

  /// Returns the shoulders measurement in centimeters.
  double get shoulders => log.get<double>('shoulders', 0);

  /// Returns the hip measurement in centimeters.
  double get hips => log.get<double>('hips', 0);

  /// Returns the thigh measurement in centimeters.
  double get thighs => log.get<double>('thighs', 0);

  /// Returns the calf measurement in centimeters.
  double get calves => log.get<double>('calves', 0);

  /// Returns the neck measurement in centimeters.
  double get neck => log.get<double>('neck', 0);

  /// Returns the height in centimeters.
  double get height => log.get<double>('height', 0);

  /// Calculate the Body Mass Index (BMI) using the weight and height.
  double get bmi =>
      height == 0 ? 0 : weight / ((height / 100) * (height / 100));
}
