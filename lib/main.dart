import 'package:crypto_trade/core/colors.dart';
import 'package:crypto_trade/features/splash/presentation/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 929),
        minTextAdapt: true,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: MyColor.backgroundColor,
            canvasColor: MyColor.backgroundColor,
            colorScheme: ColorScheme.dark(
              background: MyColor.backgroundColor,
            ),
          ),
          home: SplashView(),
        )
    );
  }
}
