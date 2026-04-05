import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

Widget errorView(String? error, VoidCallback refreshData){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: 64, color: Colors.red),
        const SizedBox(height: 16),
        Text(
          'Error loading data',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 280.w,
          child: Text(error!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),

        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: refreshData,
          child: const Text('Retry',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: MyColor.mainColor),
          ),
        ),
      ],
    ),
  );
}