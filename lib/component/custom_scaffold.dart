import 'package:flutter/material.dart';
import 'package:test_notification/component/custom_bottom_sheet.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.child, this.bottomSheetTitle});

  final String? bottomSheetTitle;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/building.webp", fit: BoxFit.cover),
          ),

          Positioned(
            bottom: 0,
            child: CustomBottomSheet(title: bottomSheetTitle, child: child),
          ),
        ],
      ),
    );
  }
}
