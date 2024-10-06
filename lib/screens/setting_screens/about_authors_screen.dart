import 'package:flutter/material.dart';

import '../../styles/layouts.dart';
import '../../widgets/nav-drawer.dart';


class AboutAuthorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'About Authors',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
