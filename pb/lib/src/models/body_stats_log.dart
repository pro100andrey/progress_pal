import 'package:pocketbase/pocketbase.dart';

extension type BodyStatsLog(RecordModel log) {
  /// Returns the ID of the log.
  String get id => log.id;

  /// Returns the user ID associated with the log.
  String get userId => log.getStringValue('user');

  /// Returns the date of the log.
  DateTime get date => DateTime.parse(log.getStringValue('date'));

  /// Returns the weight in kilograms.
  double get weight => log.getDoubleValue('weight', 0);

  /// Returns the body fat percentage.
  double get bodyFat => log.getDoubleValue('body_fat', 0);

  /// Returns the waist measurement in centimeters.
  double get waist => log.getDoubleValue('waist', 0);

  /// Returns the chest measurement in centimeters.
  double get chest => log.getDoubleValue('chest', 0);

  /// Returns the arms measurement in centimeters.
  double get arms => log.getDoubleValue('arms', 0);

  /// Returns the forearms measurement in centimeters.
  double get forearms => log.getDoubleValue('forearms', 0);

  /// Returns the shoulders measurement in centimeters.
  double get shoulders => log.getDoubleValue('shoulders', 0);

  /// Returns the hip measurement in centimeters.
  double get hips => log.getDoubleValue('hips', 0);

  /// Returns the thigh measurement in centimeters.
  double get thighs => log.getDoubleValue('thighs', 0);

  /// Returns the calf measurement in centimeters.
  double get calves => log.getDoubleValue('calves', 0);

  /// Returns the neck measurement in centimeters.
  double get neck => log.getDoubleValue('neck', 0);

  /// Returns the height in centimeters.
  double get height => log.getDoubleValue('height', 0);

  /// Calculate the Body Mass Index (BMI) using the weight and height.
  double get bmi => weight / ((height / 100) * (height / 100));
}
