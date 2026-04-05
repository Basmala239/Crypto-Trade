import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/colors.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({super.key,required this.title,required this.subTitle,required this.image});

  final String title;
  final String subTitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height:27),
          SvgPicture.asset(
            image,
          ),
          SizedBox(height:50),
          Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: MyColor.white
                ),),

          SizedBox(height:15),
          Text(subTitle,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: MyColor.gray77
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}