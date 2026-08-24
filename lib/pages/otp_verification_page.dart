import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:test_notification/component/custom_button.dart';
import 'package:test_notification/component/custom_scaffold.dart';
import 'package:test_notification/core/const_color.dart';
import 'package:test_notification/core/constants.dart';

class OtpVerificationPage extends StatefulWidget {
  final String email;
  final void Function()? onTap;

  const OtpVerificationPage({super.key, required this.email, this.onTap});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomSheetTitle: Constants.otpVerificationC,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(Constants.yourOneTimePasswordHasSentTo),
                    Text(
                      widget.email.isNotEmpty ? widget.email : "email@mail.com",
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    Constants.edit,
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                ),

                // Row(
                //   children: [
                //     CustomTextfield(),
                //     CustomTextfield(),
                //     CustomTextfield(),
                //     CustomTextfield(),
                //     CustomTextfield(),
                //     CustomTextfield(),
                //   ],
                // )
              ],
            ),
          ),

          const SizedBox(height: 10),
          Pinput(
            length: 6,
            defaultPinTheme: PinTheme(
              height: 56,
              width: 56,
              margin: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderColor),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [gradientWhite,gradientBlack ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  Constants.resendOtp,
                  style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                ),
                Text("00:00"),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Divider(color: dividerColor),
          CustomButton(title: Constants.verify, onTap: widget.onTap),
        ],
      ),
    );
  }
}
