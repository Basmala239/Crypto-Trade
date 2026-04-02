import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../features/notification/view/notification_view.dart';
import '../../features/profile/view/profile_view.dart';
import '../assets_manager.dart';

Widget customAppBar(BuildContext context){
  return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const ProfileView()));
          },
          child: ClipOval(
            child: SizedBox(
              width: 40,
              height: 40,
              child: Image.asset(AssetsManager.profile),
            ),
          ),
        ),
        Spacer(),
        TextButton(onPressed: () {},
          child: SvgPicture.asset(AssetsManager.search),),
        TextButton(onPressed: () {},
          child: SvgPicture.asset(AssetsManager.scanner),),
        TextButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => const NotificationView()));
        },
          child: SvgPicture.asset(AssetsManager.notification),)

      ]
  );
}