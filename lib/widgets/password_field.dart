import 'package:flutter/material.dart';
import 'package:zpi_project/styles/layouts.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscurePassword;
  final VoidCallback onToggle;

  const PasswordField({
    super.key,
    required this.controller,
    required this.obscurePassword,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomTextField(
      labelText: 'Password',
      controller: controller,
      obscureText: obscurePassword,
      suffixIcon: IconButton(
        icon: Icon(
          obscurePassword ? Icons.visibility_off : Icons.visibility,
          color: theme.iconTheme.color,
        ),
        onPressed: onToggle,
      ),
    );
  }
}
