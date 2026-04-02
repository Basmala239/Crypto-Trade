import 'package:flutter/material.dart';
import '../../../../core/widget/custom_buttons.dart';
import '../../../auth/auth_view.dart';
import 'custom_indicator.dart';
import 'custom_page_view.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardingViewBodyState createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  PageController? pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50,),
        SizedBox(
          width: double.infinity,
          height: 700,
          child:
        CustomPageView(
          pageController: pageController,
        )),
        CustomIndicator(
            dotIndex: pageController!.hasClients ? pageController?.page : 0,

        ),
         SizedBox(height: 50,),
         CustomButton(
              onTap: () {
                if (pageController!.page! < 2) {
                  pageController?.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                } else {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>const AuthView()) );
                }
              },
              text: 'Next',
            ),
      ],
    );
  }
}
