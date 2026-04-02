import 'package:crypto_trade/features/profile/view/widgets/profile_body.dart';
import 'package:flutter/material.dart';

import '../../../core/colors.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileBody(),
    );
  }
}
