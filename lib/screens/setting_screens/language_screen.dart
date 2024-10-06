import 'package:flutter/material.dart';

import '../../styles/layouts.dart';
import '../../widgets/nav-drawer.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Language',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
