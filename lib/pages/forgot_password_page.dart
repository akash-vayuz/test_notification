import 'package:flutter/material.dart';
import 'package:test_notification/component/custom_button.dart';
import 'package:test_notification/component/custom_scaffold.dart';
import 'package:test_notification/component/custom_textfield.dart';
import 'package:test_notification/core/const_color.dart';
import 'package:test_notification/core/constants.dart';
import 'package:test_notification/pages/otp_verification_page.dart';
import 'package:test_notification/pages/setup_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomSheetTitle: Constants.forgotPaddwordC,
      child: Column(
        children: [
          CustomTextfield(
            title: Constants.username,
            hintText: Constants.enterYourEmail,
            controller: controller,
          ),

          Divider(color: dividerColor),
          CustomButton(
            title: Constants.verify,

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OtpVerificationPage(
                    email: controller.text.trim(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SetupPasswordPage()),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
