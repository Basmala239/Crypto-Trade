import 'package:crypto_trade/features/auth/signin/presentation/widgets/signin_body.dart';
import 'package:crypto_trade/features/auth/signin/presentation/widgets/signin_tap.dart';
import 'package:crypto_trade/features/auth/signup/view/widget/sign_up_body.dart';
import 'package:flutter/material.dart';

import '../../core/colors.dart';
class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool isActive = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColor.backgroundColor,
          leading: Icon(Icons.close,
            color: MyColor.gray77,),
        ),
        body: Padding(padding: EdgeInsets.all(18),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: MyColor.secondaryColor,
                      ),
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customTap(
                              text: "Sign in", isActive: isActive, onClick: () {
                            setState(() {
                              isActive = true;
                            });
                          }),
                          customTap(text: "Sign Up",
                              isActive: !isActive,
                              onClick: () {
                                setState(() {
                                  isActive = false;
                                });
                              }),
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    if(isActive)
                      SignInBody(),
                    if(!isActive)
                      SignUpBody(),
                  ]
              ),
            )
        )
    );
  }
}

