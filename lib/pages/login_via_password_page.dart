import 'package:flutter/material.dart';
import 'package:test_notification/component/custom_button.dart';
import 'package:test_notification/component/custom_scaffold.dart';
import 'package:test_notification/component/custom_textfield.dart';
import 'package:test_notification/core/const_color.dart';
import 'package:test_notification/core/constants.dart';
import 'package:test_notification/pages/forgot_password_page.dart';
import 'package:test_notification/pages/home_page.dart';

class LoginViaPasswordPage extends StatefulWidget {
  const LoginViaPasswordPage({super.key});

  @override
  State<LoginViaPasswordPage> createState() => _LoginViaPasswordPageState();
}

class _LoginViaPasswordPageState extends State<LoginViaPasswordPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomSheetTitle: Constants.loginC,
      child: Column(
        children: [
          CustomTextfield(
            title: Constants.username,
            controller: usernameController,
          ),
          CustomTextfield(
            title: Constants.password,
            controller: passwordController,
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

          Align(
            alignment: .topRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
                );
              },
              child: const Text(
                Constants.forgetPassword,
                style: TextStyle(color: primaryColor),
              ),
            ),
          ),

          // const SizedBox(height: ),
          Divider(color:dividerColor),

          const SizedBox(height: 10),
          CustomButton(
            title: Constants.login,
onTap: (){
  Navigator.push(context, MaterialPageRoute(builder: (_)=> const MyHomePage(title: "Flutter")));
},
            // color: ,
          ),

          Row(
            mainAxisAlignment: .center,
            children: [
              const Text(Constants.notExistingUser),
              TextButton(
                onPressed: () {},

                child: const Text(
                  Constants.signUp,
                  style:TextStyle(color: primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }
}
