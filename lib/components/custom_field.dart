import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final TextInputType inputType;
  final bool obscure;
  final TextEditingController controller;
  final IconData prefixIcon;
  final Widget? suffixIcon;

  const CustomField({
    super.key,
    required this.labelText,
    this.hintText,
    required this.validator,
    required this.inputType,
    required this.obscure,
    required this.controller,
    required this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      controller: controller,
      validator: validator,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Color(0xFF113861)),
        focusColor: Colors.orange,
        hoverColor: Colors.orange,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
        ),
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
      ),
      style: const TextStyle(
          color: Color(0xFF113861), fontSize: 16, fontFamily: 'Poppins'),
    );
  }
}
