import 'package:flutter/material.dart';

import '../../styles/layouts.dart';
import '../../widgets/nav-drawer.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Edit Profile',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}