import 'package:flutter/material.dart';
import 'package:test_notification/core/const_color.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    this.controller,
    this.title,
    this.hintText,
    this.isObsecure = false,
    this.sufficIcon,
  });
  final TextEditingController? controller;
  final String? title;
  final String? hintText;
  final bool isObsecure;
  final Widget? sufficIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: const TextStyle(
                color: blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),
          ],
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: borderColor),
              color: primaryColor,
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [gradientWhite, gradientBlack],
              // ),
            ),
            child: TextFormField(
              controller: controller,
              cursorColor: whiteColor,
              textInputAction: TextInputAction.next,
              obscureText: isObsecure,

              style: const TextStyle(color: whiteColor),
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIconConstraints: const BoxConstraints(
                  maxHeight: 48,
                  maxWidth: 48,
                  // minHeight: 48,
                  minWidth: 48,
                ),
                suffixIcon: sufficIcon,
                hintText: hintText,
                hintStyle: const TextStyle(color: whiteColor),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                fillColor: transparentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
