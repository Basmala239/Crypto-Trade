import 'dart:ui';

class HomeGridItemModel {
  String icon;
  String label;
  VoidCallback onClick;
  HomeGridItemModel({
    required this.icon,
    required this.label,
    required this.onClick,
  });
}