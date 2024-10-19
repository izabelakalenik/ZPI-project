import 'package:flutter/material.dart';
import 'package:feedback/feedback.dart';
import 'app.dart';
import 'languages/localization_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalizationUtils.instance.initialize();

  runApp(
      const BetterFeedback(child:App()));
}
