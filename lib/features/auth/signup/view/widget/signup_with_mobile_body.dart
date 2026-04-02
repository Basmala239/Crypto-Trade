import 'package:flutter/material.dart';

import '../../../../../core/colors.dart';
import '../../../../../core/widget/custom_buttons.dart';
import '../../../../../core/widget/custom_text_field.dart';
import '../../../../../core/widget/header_text.dart';
import '../../../otp_verification/view/otp_verification_view.dart';

class SignupWithMobileBody extends StatelessWidget {
  const SignupWithMobileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerText("Register with mobile"),
        SizedBox(height: 30,),
        Text("Please type your number, then we’ll send a verification code for authentication."),
        SizedBox(height: 50,),
        Text('Mobile Number',
          style: TextStyle(color: MyColor.grayB7),),
        SizedBox(height: 10,),
        CustomTextField(
          hint: 'Enter your mobile',
          onTap: () {},
        ),
        SizedBox(height: 50,),
        CustomButton(text: "Send OTP", onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>const OtpVerificationView()) );
        },editWidth: double.infinity,),
      ],
    );
  }
}
