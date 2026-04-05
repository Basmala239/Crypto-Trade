import 'package:flutter/cupertino.dart';

class ProfileItemModel {
  final String label;
  final String value;
  final IconData? icon;
  final bool isEditable;

  ProfileItemModel({
    required this.label,
    required this.value,
    this.icon,
    this.isEditable = false,
  });
}