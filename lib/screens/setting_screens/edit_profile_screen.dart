import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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