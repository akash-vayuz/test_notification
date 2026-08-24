import 'package:flutter/material.dart';
import 'package:test_notification/component/custom_button.dart';
import 'package:test_notification/component/custom_scaffold.dart';
import 'package:test_notification/core/const_color.dart';
import 'package:test_notification/core/constants.dart';
import 'package:test_notification/pages/login_via_otp_page.dart';
import 'package:test_notification/pages/login_via_password_page.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _HomePageState();
}

class _HomePageState extends State<OnBoardPage> {

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Text(
            Constants.welcome,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const Text(Constants.goodToSeeYou, style: TextStyle(fontSize: 18)),
          const SizedBox(height: 20),

          CustomButton(title: Constants.loginViaOtp,onTap: (){
 Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginViaOtpPage()),
              );
          },),

          const SizedBox(height: 10),
          CustomButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginViaPasswordPage()),
              );
            },
            title: Constants.loginViaPassword,
            color: whiteColor,
            textColor: blackColor,
          ),

          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: .center,
            children: [
              const Text(Constants.notExistingUser),
              TextButton(
                onPressed: () {},
                child: const Text(
                  Constants.signUp,
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

