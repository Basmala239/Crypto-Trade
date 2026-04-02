import 'package:crypto_trade/features/onboarding/presentation/widgets/onboarding_body.dart';
import 'package:flutter/material.dart';

import '../../../core/colors.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(padding: EdgeInsetsGeometry.all(18),
        child: const OnBoardingViewBody()
      ),
    );
  }
}