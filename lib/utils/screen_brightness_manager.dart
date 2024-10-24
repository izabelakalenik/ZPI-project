import 'package:flutter/cupertino.dart';
import 'package:screen_brightness/screen_brightness.dart';

class ScreenBrightnessManager {
  double _originalBrightness = 0.5;

  // Get the current brightness of the application
  Future<void> getApplicationBrightness() async {
    try {
      _originalBrightness = await ScreenBrightness.instance.application;
    } catch (e) {
      debugPrint("Failed to get application brightness: $e");
      throw 'Failed to get application brightness';
    }
  }

  // Set the screen brightness to the specified value
  Future<void> setApplicationBrightness(double brightness) async {
    try {
      await ScreenBrightness.instance.setApplicationScreenBrightness(brightness);
    } catch (e) {
      debugPrint("Failed to set application brightness: $e");
      throw 'Failed to set application brightness';
    }
  }

  // Increase brightness to maximum (1.0)
  Future<void> increaseBrightness() async {
    await getApplicationBrightness(); // Save current brightness first
    await setApplicationBrightness(1.0); // Set to maximum
  }

  // Restore the original brightness
  Future<void> restoreBrightness() async {
    await setApplicationBrightness(_originalBrightness); // Restore the original brightness
  }
}