import 'package:flutter/material.dart';
import 'package:grad_app/resources/app_colors.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback? function;
  final IconData iconData;
  Color? color;
  DefaultButton({
    super.key,
    required this.text,
    required this.iconData,
    required this.function,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? AppColors.kPrimaryColor,
          ),
          onPressed: function,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData),
              const SizedBox(
                width: 5,
              ),
              Text(
                text,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
            ],
          )),
    );
  }
}
