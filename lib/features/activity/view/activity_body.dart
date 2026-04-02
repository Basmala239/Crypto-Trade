import 'package:crypto_trade/features/activity/view/widgets/activity_list.dart';
import 'package:crypto_trade/features/activity/view/widgets/header_item.dart';
import 'package:flutter/material.dart';

import '../../../core/widget/custom_app_bar.dart';

class ActivityBody extends StatelessWidget {
  const ActivityBody({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              customAppBar(context),
              SizedBox(height: 20,),
              headerItems(),
              SizedBox(height: 20,),
              Text("Recent Activity", style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),),
              SizedBox(height: 20,),
              Expanded(
                child: activityList(),
              ),
            ],
          )
      )
    ;
  }
}
