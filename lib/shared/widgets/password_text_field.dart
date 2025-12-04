import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

/// Custom password text field with show/hide toggle
class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool enabled;
  final EdgeInsets contentPadding;

  const PasswordTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
    this.enabled = true,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      enabled: widget.enabled,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText ?? 'Password',
        contentPadding: widget.contentPadding,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColors.textSecondary,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
