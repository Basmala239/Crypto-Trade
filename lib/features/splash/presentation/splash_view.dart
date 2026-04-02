import 'package:crypto_trade/features/splash/presentation/widgets/splash_body.dart';
import 'package:flutter/material.dart';

import '../../../core/colors.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashBody(),
    );
  }
}