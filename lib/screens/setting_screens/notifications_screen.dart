import 'package:flutter/material.dart';

import '../../styles/layouts.dart';
import '../../widgets/nav-drawer.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Notifications',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}