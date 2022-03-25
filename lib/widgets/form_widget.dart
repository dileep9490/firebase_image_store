import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    Key? key,
    required this.controller,
    required this.textInputAction,
    required this.prefixIcon,
    required this.hintText,
    this.obscureText = false,
    required this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final IconData prefixIcon;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: controller,
      onSaved: (value) {
        controller.text = value!;
      },
      validator: validator,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
