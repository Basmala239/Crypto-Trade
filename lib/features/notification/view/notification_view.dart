import 'package:crypto_trade/features/notification/view/widgets/notification_body.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationBody(),
    );
  }
}
