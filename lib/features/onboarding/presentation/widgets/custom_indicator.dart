import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../core/colors.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({Key? key,@required this.dotIndex}) : super(key: key);
  final double? dotIndex;

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: 3,
      position: dotIndex!.toInt(),
      decorator: DotsDecorator(
        activeColor: MyColor.gray77,
        color: MyColor.gray35,
      ),
    );
  }
}