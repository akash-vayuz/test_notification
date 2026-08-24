import 'package:flutter/material.dart';
import 'package:test_notification/core/const_color.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
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
              style: const TextStyle(color: blackColor, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
          ],
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color:borderColor),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [gradientWhite, gradientBlack],
              ),
            ),
            child: TextFormField(
              controller: controller,
              textInputAction: TextInputAction.next,
              obscureText: isObsecure,

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
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                fillColor: transparentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
