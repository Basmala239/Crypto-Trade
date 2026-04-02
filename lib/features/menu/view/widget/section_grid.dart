import 'package:flutter/material.dart';

import '../../../../data/model/home_grid_item_model.dart';
import '../../../home/view/widget/home_grid_item_widget.dart';

Widget sectionGrid(List<HomeGridItemModel> gridList){
  return GridView.builder(
    padding: EdgeInsetsGeometry.only(top:8,bottom: 20 ),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    ),
    itemCount: gridList.length,
    itemBuilder: (context, index) {
      return homeGridItemWidget(gridList[index]);
    },
  );
}