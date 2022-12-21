import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:seat/utils/AppConstants.dart';
import 'package:seat/utils/HexColor.dart';

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

class VersionCode {
  String code = 'Powered by RJ';

  VersionCode(this.code);
}

class LocalTimeZone {
  String timezone = 'Australia/Sydney';

  LocalTimeZone(this.timezone);
}

class CommonUtils {
  static const int MIN_IMAGE_HEIGHT = 700;
  static const int MIN_IMAGE_WIDTH = 300;
  static const int IMAGE_QUALITY = 75;

  static String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  static setDataInTextEditingController(TextEditingController? controller, String? value) {
    if (controller != null && checkIfNotNull(value)) {
      controller.text = value!;
    }
  }

  static bool checkIfLatitude(String? value) {
    if (checkIfNotNull(value)) {
      double lat = getDouble(value);
      return lat != 0 && lat >= -90 && lat <= 90;
    }
    return false;
  }

  static bool checkIfLongitude(String? value) {
    if (checkIfNotNull(value)) {
      double lon = getDouble(value);
      return lon != 0 && lon >= -180 && lon <= 180;
    }
    return false;
  }

  static bool isValidEmail(String? email) {
    if (checkIfNotNull(email)) {
      RegExp regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        caseSensitive: false,
        multiLine: false,
      );
      if (regExp.hasMatch(email!)) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  static bool isValidPhone(String? phone) {
    if (checkIfNotNull(phone)) {
      RegExp regExp = RegExp(
        r"^(?:[+0])?[0-9]{9,12}$",
        caseSensitive: false,
        multiLine: false,
      );
      if (regExp.hasMatch(phone!)) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  static bool checkIfNotNull(String? value) {
    return value != null && value.trim().isNotEmpty && value.trim() != NULL && value.trim() != "";
  }

  static String replaceIfNull(String? value) {
    return checkIfNotNull(value) ? value! : '';
  }

  static String replaceWithUnknown(String? value) {
    return checkIfNotNull(value) ? value! : 'Unknown';
  }

  static bool checkIfBlank(String? value) {
    return value != null && value.isNotEmpty && value.trim() != "";
  }

  static String replaceToSmallCase(String? value) {
    if (checkIfNotNull(value)) {
      return value!.toLowerCase().trim();
    }
    return '';
  }

  static int getInt(String? value) {
    if (CommonUtils.checkIfNotNull(value)) {
      try {
        var intVal = int.parse(value!);
        assert(intVal is int);
        return intVal;
      } catch (Exception) {
        return 0;
      }
    }
    return 0;
  }

  static Color getColorPerStatus(String? status) {
    if (CommonUtils.checkIfNotNull(status)) {
      if (status!.trim().toLowerCase().contains('applied') ||
          status.trim().toLowerCase().contains('new') ||
          status.trim().toLowerCase().contains('interested')) {
        return HexColor.getColor('F4591B');
      } else if (status.trim().toLowerCase().contains('eligible')) {
        return HexColor.getColor('2C4F47');
      } else if (status.trim().toLowerCase().contains('progress')) {
        return HexColor.getColor('CB9E1D');
      } else if (status.trim().toLowerCase().contains('offer') ||
          status.trim().toLowerCase().contains('sent') ||
          status.trim().toLowerCase().contains('completed') ||
          status.trim().toLowerCase().contains('completed')) {
        return HexColor.getColor('A240A9');
      } else if (status.trim().toLowerCase().contains('existing') ||
          status.trim().toLowerCase().contains('fedex') ||
          status.trim().toLowerCase().contains('hire') ||
          status.trim().toLowerCase().contains('hired') ||
          status.trim().toLowerCase().contains('driver')) {
        return HexColor.getColor('8EBB74');
      } else if (status.trim().toLowerCase().contains('drug') || status.trim().toLowerCase().contains('screening')) {
        return HexColor.getColor('F22A2A');
      }
    }
    return HexColor.getColor('CB9E1D');
  }

  static Color getColorPerTest(String? status) {
    if (CommonUtils.checkIfNotNull(status)) {
      if (status!.trim().toLowerCase().contains('drug')) {
        return HexColor.getColor('b9a178');
      } else if (status.trim().toLowerCase().contains('road')) {
        return HexColor.getColor('5bafad');
      } else if (status.trim().toLowerCase().contains('background') ||
          status.trim().toLowerCase().contains('green') ||
          status.trim().toLowerCase().contains('mvr')) {
        return HexColor.getColor('15995A');
      } else if (status.trim().toLowerCase().contains('dot') || status.trim().toLowerCase().contains('training')) {
        return HexColor.getColor('BD8392');
      }
    }
    return HexColor.getColor('EDA4B7');
  }

  static Future<int> getWeekStartDay() async {
    /* AppDatabase? database = await CommonUtils.getFloorDatabase();
    UserDao userDao = database.userDao;
    ClientDao clientDao = database.clientDao;

    if (userDao != null && clientDao != null) {
      List<User> userList = await userDao.findAllUser();
      if (userList != null && userList.isNotEmpty) {
        User mUser = userList[0];
        if (mUser != null && CommonUtils.checkIfNotNull(mUser.user_token) && CommonUtils.checkIfNotNull(mUser.login_status)) {
          Client? mClient = await clientDao.findClientById(mUser.client_id!);
          if (mClient != null && mClient.client_start_week != null && mClient.client_start_week! > 0) {
            return mClient.client_start_week! - 1;
          }
        }
      }
    }*/
    return 0;
  }

  static String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  static String humanReadableByteCount(int bytes) {
    int unit = 1024;
    if (bytes < unit) return bytes.toString() + " B";
    int exp = log(bytes) ~/ log(unit);
    String pre = ("KMGTPE")[exp - 1] + "";
    double value = bytes / pow(unit, exp);
    String finalValue = format(value);
    return finalValue + ' ' + pre + 'B';
  }

  static String removeLastCharacter(String? str) {
    String result = '';
    if (checkIfNotNull(str)) {
      result = str!.substring(0, str.length - 1);
    }

    return result;
  }

  static bool getJSONBool(Map<String, dynamic> json, String key) {
    if (CommonUtils.checkIfNotNull(key) && json[key] != null) {
      if (json[key] is bool) {
        return json[key] as bool;
      } else if (json[key] is String && CommonUtils.checkIfNotNull(json[key] as String?)) {
        return (((json[key] as String).trim().toLowerCase() == "yes") || ((json[key] as String).trim().toLowerCase() == "true"));
      }
    }
    return false;
  }

  static String getJSONString(Map<String, dynamic> json, String key) {
    if (CommonUtils.checkIfNotNull(key) && json[key] != null) {
      if (json[key] is String) {
        return json[key] as String;
      } else if (json[key] is int) {
        return CommonUtils.getIntToString(json[key] as int);
      } else if (json[key] is String && CommonUtils.checkIfNotNull(json[key] as String?)) {
        return ((((json[key] as String).trim().toLowerCase() == "yes") || ((json[key] as String).trim().toLowerCase() == "true")) ? "True" : "False");
      }
    }
    return "";
  }

  static int getJSONInt(Map<String, dynamic> json, String key) {
    if (CommonUtils.checkIfNotNull(key) && json[key] != null) {
      if (json[key] is String) {
        return getStringToInt((json[key] as String));
      } else if (json[key] is int) {
        return json[key] as int;
      } else if (json[key] is String && CommonUtils.checkIfNotNull(json[key] as String?)) {
        return ((((json[key] as String).trim().toLowerCase() == "yes") || ((json[key] as String).trim().toLowerCase() == "true")) ? 1 : 0);
      }
    }
    return -1;
  }

  static double getDouble(String? value) {
    if (CommonUtils.checkIfNotNull(value)) {
      try {
        var doubleVal = double.parse(value!);
        assert(doubleVal is double);
        return doubleVal;
      } catch (Exception) {
        return 0;
      }
    }
    return 0;
  }

  static String getFormattedValue(String? value) {
    if (checkIfNotNull(value)) {
      var doubleVl = double.parse(value!);
      return doubleVl.toStringAsFixed(2);
    }
    return '0.0';
  }

  static String getStringFormattedValue(double? value) {
    if (value != null) {
      try {
        var stringVal = value.toStringAsFixed(2);
        assert(stringVal is String);
        return stringVal;
      } catch (Exception) {
        return '0.0';
      }
    }
    return '0.0';
  }

  static String getDoubleToString(double? value) {
    try {
      var stringVal = value.toString();
      assert(stringVal is String);
      return stringVal;
    } catch (Exception) {
      return '';
    }
    return '';
  }

  static String getIntToString(int? value) {
    try {
      var stringVal = value.toString();
      assert(stringVal is String);
      return stringVal;
    } catch (Exception) {
      return '';
    }
    return '';
  }

  static int getStringToInt(String? value) {
    try {
      if (CommonUtils.checkIfNotNull(value)) {
        var intVal = int.parse(value!);
        assert(intVal is int);
        return intVal;
      }
    } catch (Exception) {
      return -1;
    }
    return -1;
  }

  static bool contains(String? value1, String? value2, {bool ignoreCase = false}) {
    if (checkIfNotNull(value1) && checkIfNotNull(value2)) {
      if (ignoreCase) {
        return value1.toString().toLowerCase().trim().contains(value2.toString().toLowerCase().trim());
      } else {
        return value1.toString().trim().contains(value2.toString().trim());
      }
    }
    return false;
  }

  static BuildContext? getBuildContext(GlobalKey<ScaffoldState>? _scaffoldKey, BuildContext? context) {
    if (_scaffoldKey != null && _scaffoldKey.currentState != null) {
      if (_scaffoldKey.currentState!.context != null) {
        return _scaffoldKey.currentState!.context;
      } else if (_scaffoldKey.currentContext != null) {
        return _scaffoldKey.currentContext;
      }
    } else if (context != null) {
      return context;
    }
    return null;
  }

  static bool equalsIgnoreCase(String? string1, String? string2) {
    if (CommonUtils.checkIfNotNull(string1) && CommonUtils.checkIfNotNull(string2)) {
      return string1!.toLowerCase() == string2!.toLowerCase();
    }
    return false;
  }
}
