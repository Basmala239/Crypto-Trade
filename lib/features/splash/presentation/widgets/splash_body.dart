import 'package:crypto_trade/features/auth/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets_manager.dart';
import '../../../../data/repository/user_repository.dart';
import '../../../home/view/home_layout.dart';
import '../../../onboarding/presentation/onboarding_view.dart';
class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  final UserRepository _userRepo = UserRepository();

  void goView() async{
    if (await _userRepo.getIsFirstVisit() == false) {
      goToNextView(context, AuthView());
    } else if(await _userRepo.getRememberMe() == true) {
      goToNextView(context, HomeLayout());
    }else {
      goToNextView(context, OnBoardingView());
    }
  }

  @override
  Widget build(BuildContext context) {
    goView();
    return Container(
      alignment: Alignment.center,
      child: SvgPicture.asset(
          AssetsManager.logo,
          semanticsLabel: 'Acme Logo'
      ),

    );
  }
}
void goToNextView(context, Widget view){

  Future.delayed(const Duration(seconds: 3),(){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>view) );
  });
}