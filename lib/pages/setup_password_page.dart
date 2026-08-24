import 'package:flutter/material.dart';
import 'package:test_notification/component/custom_button.dart';
import 'package:test_notification/component/custom_scaffold.dart';
import 'package:test_notification/component/custom_textfield.dart';
import 'package:test_notification/core/const_color.dart';
import 'package:test_notification/core/constants.dart';
import 'package:test_notification/pages/home_page.dart';

class SetupPasswordPage extends StatefulWidget {
  const SetupPasswordPage({super.key});

  @override
  State<SetupPasswordPage> createState() => _SetupPasswordPageState();
}

class _SetupPasswordPageState extends State<SetupPasswordPage> {
  bool isObsecure = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomSheetTitle: Constants.setupPasswordC,
      child: Column(
        children: [
          const CustomTextfield(title: Constants.username),
          CustomTextfield(
            title: Constants.password,
            isObsecure: isObsecure,
            sufficIcon: InkWell(
              onTap: () => setState(() {
                isObsecure = !isObsecure;
              }),
              child: Icon(
                isObsecure
                    ? Icons.remove_red_eye_rounded
                    : Icons.visibility_off,
                size: 18,
              ),
            ),
          ),

          const SizedBox(height: 20),
          Divider(color: dividerColor),
          CustomButton(
            title: Constants.verify,

            // Navigator.push(context, MaterialPageRoute(builder: (_)=>()));
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyHomePage(title: "Flutter")),
              );
            },
          ),
        ],
      ),
    );
  }
}
