import 'package:crypto_trade/features/onboarding/presentation/widgets/page_view_item.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets_manager.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({super.key,required this.pageController});
  final PageController? pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController ,
      children: const [
        PageViewItem(
          image: AssetsManager.onboarding1,
          title: 'Trade anytime anywhere',
          subTitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.',
        ),
        PageViewItem(
          image: AssetsManager.onboarding2,
          title: 'Save and invest at the same time',
          subTitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.',
        ),
        PageViewItem(
          image: AssetsManager.onboarding3,
          title: 'Transact fast and easy',
          subTitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.',
        ),

      ],
    );
  }
}