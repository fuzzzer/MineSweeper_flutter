import 'package:flutter/Material.dart';

List<List<int>> generate2DIntList(final int n, final int m) {
  final result = List<List<int>>.generate(
      n, (i) => List<int>.generate(m, (j) => 0, growable: false),
      growable: false);
  return result;
}

List<List<bool>> generate2DBoolList(final int n, final int m) {
  final result = List<List<bool>>.generate(
      n, (i) => List<bool>.generate(m, (j) => false, growable: false),
      growable: false);
  return result;
}

bool isNumeric(String s) {
  return int.tryParse(s) != null;
}

bool checkTouchability(context) {
  return !(Theme.of(context).platform == TargetPlatform.iOS ||
      Theme.of(context).platform == TargetPlatform.android);
}
