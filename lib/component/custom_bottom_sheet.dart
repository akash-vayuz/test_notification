import 'package:flutter/material.dart';
import 'package:test_notification/component/handler_widget.dart';
import 'package:test_notification/core/const_color.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key, this.title, this.child});

  final String? title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: whiteColor,
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          const HandlerWidget(),

          if (title != null) ...[
            const SizedBox(height: 10),
            Text(
              title!,
              style: const TextStyle(
                fontSize: 20,
                color: blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],

          const SizedBox(height: 6),
          Divider(color: dividerColor),
          const SizedBox(height: 10),

          ?child,
        ],
      ),
    );
  }
}
