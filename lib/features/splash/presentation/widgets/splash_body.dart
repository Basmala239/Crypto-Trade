import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets_manager.dart';
import '../../../onboarding/presentation/onboarding_view.dart';
class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {

  @override
  void initState() {
    super.initState();
    goToNextView(context);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SvgPicture.asset(
          AssetsManager.logo,
          semanticsLabel: 'Acme Logo'
      ),
    );
  }
}
void goToNextView(context){
  Future.delayed(const Duration(seconds: 3),(){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>const OnBoardingView()) );
  });
}