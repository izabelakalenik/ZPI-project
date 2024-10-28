// input_validation.dart
import 'package:flutter/material.dart';

class InputValidation {

  static SnackBar errorMessage(String error){
    return SnackBar(
      content: Text(error),
      duration: const Duration(seconds: 3),
    );
  }

  static bool validateYear(String yearText) {
    try {
      int year = int.parse(yearText);
      if (year < 1900 || year > DateTime.now().year) {
        return false;
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  static bool validateFields(Map<String, String> fields) {
    for (var entry in fields.entries) {
      if (entry.value.isEmpty) {
        return false;
      }
    }
    return true;
  }
}
