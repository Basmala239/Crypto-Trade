import 'package:crypto_trade/core/assets_manager.dart';
import 'package:crypto_trade/data/model/notification_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/colors.dart';
import '../../../../core/widget/empty_view.dart';
import 'notification_header.dart';
import 'notification_item.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 40),
            notificationHeader(() {}, context),
            SizedBox(height: 16,),
            NotificationModel.notificationList.isEmpty ?
            emptyView(AssetsManager.noNotification, 'You have no notifications',
                'lorem ipsum lorem ipsum') :
            Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: NotificationModel.notificationList.length,
                  itemBuilder: (BuildContext context, int index) =>
                      notificationItemWidget(
                          NotificationModel.notificationList[index]),
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(color: MyColor.gray77,),

                ))
          ],
        )

    );
  }
}
