import 'package:crypto_trade/features/setting/view/settings_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/colors.dart';
import '../../../../data/model/profile_item_model.dart';

Widget profileItem(
    ProfileItemModel item,
    BuildContext context, {
      bool isEditing = false,
      TextEditingController? controller,
      Function(String)? onValueChanged,
    }) {
  if (isEditing && item.isEditable && controller != null) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            child: Icon(
              item.icon ?? Icons.person,
              color: MyColor.mainColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),

          SizedBox(
            width: 120,
            child: Text(
              item.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              obscureText: item.label == "Password",
              decoration: InputDecoration(
                hintText: item.label == "Password" ? "Enter new password" : "Enter ${item.label.toLowerCase()}",
                hintStyle: TextStyle(color: MyColor.gray77),
                border: InputBorder.none,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: MyColor.gray77),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: MyColor.mainColor),
                ),
              ),
              onChanged: onValueChanged,
            ),
          ),
        ],
      ),
    );
  }

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Container(
          width: 40,
          child: Icon(
            item.icon ?? Icons.person,
            color: MyColor.mainColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),

        SizedBox(
          width: 120,
          child: Text(
            item.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        Expanded(
          child: Text(
            item.value,
            style: TextStyle(
              color: item.label == "Favorites" ? MyColor.mainColor : Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.end,
          ),
        ),

        if (item.label == "Settings")
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, color: MyColor.gray77, size: 16),
            onPressed: () {
              if (item.label == "Settings") {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsView()));
              }
            },
          ),
      ],
    ),
  );
}