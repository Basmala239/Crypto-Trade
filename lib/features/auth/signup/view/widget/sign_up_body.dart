import 'package:crypto_trade/core/colors.dart';
import 'package:crypto_trade/features/home/view/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/assets_manager.dart';
import '../../../../../core/widget/custom_buttons.dart';
import '../../../../../core/widget/custom_text_field.dart';
import '../../../../../core/widget/header_text.dart';
import '../../../signin/presentation/widgets/icon_button.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            headerText("Sign up"),
            SizedBox(height: 30,),
            Row(
              children: [
                Text("Email",
                  style: TextStyle(color: MyColor.grayB7),),
                Spacer(),
                Text("Sign up with mobile",
                  style: TextStyle(color: MyColor.mainColor),),
              ],
            ),
            SizedBox(height: 10,),
            CustomTextField(
              hint: 'Enter your email',
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
            CustomButton(text: "Sign up", onTap: () {
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
