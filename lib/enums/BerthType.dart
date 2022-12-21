import 'package:seat/utils/CommonUtils.dart';

enum BerthType { LOWER, MIDDLE, UPPER, SIDE_LOWER, SIDE_UPPER }

extension ParseToString on BerthType {
  String toTitleString() {
    return this.toString().split('.').last.replaceAll("_", " ").toTitleCase().trim();
  }
}
