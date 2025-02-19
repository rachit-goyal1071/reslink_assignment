import 'package:flutter/foundation.dart';
import 'package:screen_brightness/screen_brightness.dart';

class HomeRepo {

  static Future<double> systemBrightness() async {
    try {
      final data = await ScreenBrightness.instance.system;
      return data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw 'Failed to get system brightness';
    }
  }

  static Future<void> setApplicationBrightness(double brightness) async {
    try {
      await ScreenBrightness.instance
          .setApplicationScreenBrightness(brightness);
    } catch (e) {
      debugPrint(e.toString());
      throw 'Failed to set application brightness';
    }
  }

}