import 'package:flutter/material.dart';
import 'package:test_notification/core/const_color.dart';

class HandlerWidget extends StatelessWidget {
  const HandlerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:handlerColor,
      ),
    );
  }
}
