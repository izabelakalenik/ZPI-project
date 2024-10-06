import 'package:flutter/material.dart';

import '../../styles/layouts.dart';
import '../../widgets/nav-drawer.dart';

class ReportProblemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Report Problem',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}