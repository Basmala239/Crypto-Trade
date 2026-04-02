import 'package:crypto_trade/core/assets_manager.dart';
import 'package:crypto_trade/core/colors.dart';
import 'package:crypto_trade/features/home/view/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/widget/custom_buttons.dart';
import '../../../../../core/widget/custom_text_field.dart';
import '../../../../../core/widget/header_text.dart';
import 'icon_button.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {

  bool isEmail= true;

  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              headerText("Sign in"),
              SizedBox(height: 30,),
              Row(
                children: [
                  Text(isEmail ? "Email" : "Mobile Number",
                    style: TextStyle(color: MyColor.grayB7),),
                  Spacer(),
                  Text("Sign in with ",
                    style: TextStyle(color: MyColor.mainColor),),
                  Text(isEmail ? "mobile" : "email",
                    style: TextStyle(color: MyColor.mainColor),),
                ],
              ),
              SizedBox(height: 10,),
              CustomTextField(
                hint: 'Enter your ${isEmail ? 'email' : 'mobile'}',
                onTap: () {},),
              SizedBox(height: 20,),
              Text('Password',
                style: TextStyle(color: MyColor.grayB7),),
              SizedBox(height: 10,),
              CustomTextField(
                hint: 'Enter your password',
                isPassword: true,
                onTap: () {},
              ),
              SizedBox(height: 10,),
              Text('Forget Password',
                style: TextStyle(color: MyColor.mainColor),),
              SizedBox(height: 30,),
              CustomButton(text: "Sign in", onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeLayout()));
              }, editWidth: double.infinity,),
              SizedBox(height: 30,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Or Login with',
                      style: TextStyle(color: MyColor.grayB7),),
                  ]
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  CustomIconButton(text: "Facebook",
                      icon: AssetsManager.facebook,
                      onTap: () {}),
                  Spacer(),
                  CustomIconButton(
                      text: "Google", onTap: () {}, icon: AssetsManager.google),
                ],
              ),
              SizedBox(height: 50,),
              Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(AssetsManager.fingerprint),
                      SizedBox(height: 20,),
                      Text("Use fingerprint instead?", style: TextStyle(
                          color: MyColor.grayB7,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),)
                    ],
                  )
              )
            ],
          )
      );
  }
}
