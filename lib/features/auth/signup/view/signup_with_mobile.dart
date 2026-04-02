import 'package:crypto_trade/core/colors.dart';
import 'package:crypto_trade/features/auth/signup/view/widget/signup_with_mobile_body.dart';
import 'package:flutter/material.dart';

class SignupWithMobile extends StatelessWidget {
  const SignupWithMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColor.backgroundColor,
        leading: Icon(Icons.arrow_back, color: MyColor.gray77,),
        title: Text("Sigh Up",
        style: TextStyle(
          color: MyColor.grayB7,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),),
      ),
      body: SignupWithMobileBody(),
    );
  }
}
