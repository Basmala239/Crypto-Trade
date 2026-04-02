import 'package:crypto_trade/features/menu/view/widget/section_grid.dart';
import 'package:crypto_trade/features/menu/view/widget/section_title.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/home_grid_item_model.dart';

Widget menuSection(String title, List<HomeGridItemModel> gridList) {
  return Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(title),
        sectionGrid(gridList)
      ],
    ),
  );
}