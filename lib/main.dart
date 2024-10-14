import 'package:flutter/material.dart';
import 'languages/localization_utils.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalizationUtils.instance.initialize();

  runApp(App());
}
