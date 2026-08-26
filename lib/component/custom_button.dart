import 'package:flutter/material.dart';
import 'package:test_notification/core/const_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.color,
    this.textColor,
    this.margin,
    this.borderColor,
    this.onTap,
  });

  final String title;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final EdgeInsets? margin;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: color ?? blackColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor ?? blackColor),
        ),

        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: textColor ?? whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
