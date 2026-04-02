import 'dart:ui';

import 'package:crypto_trade/core/colors.dart';

class NotificationModel {
  String title;
  String subTitle;
  Color stateColor;
  NotificationModel._({required this.title, required this.subTitle, required this.stateColor});
  static List<NotificationModel> notificationList=[
  NotificationModel._(title: 'Withdrawal Successful', subTitle: 'You have successfully withdrawed lorem ipsum dolor sit...', stateColor: MyColor.mainColor),
  NotificationModel._(title: 'Deposit Successful', subTitle: 'You have successfully deposited lorem ipsum dolor sit...', stateColor: MyColor.yellow5E),
  NotificationModel._(title: 'Login From An Unknown Device', subTitle: 'You have successfully withdrawed lorem ipsum dolor sit...', stateColor: MyColor.pink4B),
  NotificationModel._(title: 'Withdrawal Successful', subTitle: 'You have successfully withdrawed lorem ipsum dolor sit...', stateColor: MyColor.mainColor),
  NotificationModel._(title: 'Deposit Successful', subTitle: 'You have successfully deposited lorem ipsum dolor sit...', stateColor: MyColor.yellow5E),
  NotificationModel._(title: 'Login From An Unknown Device', subTitle: 'You have successfully withdrawed lorem ipsum dolor sit...', stateColor: MyColor.pink4B),
  NotificationModel._(title: 'Withdrawal Successful', subTitle: 'You have successfully withdrawed lorem ipsum dolor sit...', stateColor: MyColor.mainColor),
  NotificationModel._(title: 'Deposit Successful', subTitle: 'You have successfully deposited lorem ipsum dolor sit...', stateColor: MyColor.yellow5E),
  NotificationModel._(title: 'Login From An Unknown Device', subTitle: 'You have successfully withdrawed lorem ipsum dolor sit...', stateColor: MyColor.pink4B),
  NotificationModel._(title: 'Withdrawal Successful', subTitle: 'You have successfully withdrawed lorem ipsum dolor sit...', stateColor: MyColor.mainColor),
  NotificationModel._(title: 'Deposit Successful', subTitle: 'You have successfully deposited lorem ipsum dolor sit...', stateColor: MyColor.yellow5E),
  NotificationModel._(title: 'Login From An Unknown Device', subTitle: 'You have successfully withdrawed lorem ipsum dolor sit...', stateColor: MyColor.pink4B),
  ];
}