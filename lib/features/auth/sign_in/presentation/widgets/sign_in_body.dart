import 'package:crypto_trade/core/colors.dart';
import 'package:crypto_trade/features/home/view/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/assets_manager.dart';
import '../../../../../core/widget/custom_buttons.dart';
import '../../../../../core/widget/custom_text_field.dart';
import '../../../../../core/widget/header_text.dart';
import '../../../../../data/model/user.dart';
import '../../../../../data/repository/user_repository.dart';
import 'icon_button.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  final UserRepository _userRepo = UserRepository();

  bool isEmail = true;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool isCheckboxSelected = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regExp = RegExp(emailPattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }

    final phonePattern = r'^[0-9]{10,15}$';
    final regExp = RegExp(phonePattern);

    if (!regExp.hasMatch(value.replaceAll(RegExp(r'[^0-9]'), ''))) {
      return 'Please enter a valid mobile number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final email = isEmail ? _emailController.text.trim() : _mobileController.text.trim();
      final password = _passwordController.text;

      User? user;

      if (isEmail) {
        user = await _userRepo.authenticateUser(email, password);
      } else {
        final allUsers = await _userRepo.getAllUsers();
        user = allUsers.firstWhere(
              (u) => u.phone == email && u.password == password,
          orElse: () => throw Exception('Invalid credentials'),
        );
      }

      if (user != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful!'),
              backgroundColor: Colors.green,
            ),
          );

          await _userRepo.setUserId(user.id!);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeLayout(),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid email or password'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerText("Sign in"),
            const SizedBox(height: 30),

            Row(
              children: [
                Text(isEmail ? "Email" : "Mobile Number",
                  style: const TextStyle(color: MyColor.grayB7),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isEmail = !isEmail;
                      if (isEmail) {
                        _mobileController.clear();
                      } else {
                        _emailController.clear();
                      }
                    });
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Sign in with ",
                          style: TextStyle(color: MyColor.mainColor),
                        ),
                        TextSpan(
                          text: isEmail ? "mobile" : "email",
                          style: const TextStyle(color: MyColor.mainColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            isEmail
                ? CustomTextField(
              controller: _emailController,
              hint: 'Enter your email',
              validator: _validateEmail,
              onTap: () {},
            )
                : CustomTextField(
              controller: _mobileController,
              hint: 'Enter your mobile number',
              validator: _validateMobile,
              onTap: () {},
            ),
            const SizedBox(height: 20),
            const Text('Password',
              style: TextStyle(color: MyColor.grayB7),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _passwordController,
              hint: 'Enter your password',
              isPassword: true,
              obscureText: _obscurePassword,
              validator: _validatePassword,
              onToggleVisibility: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              onTap: () {},
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Forgot password feature coming soon'),
                      ),
                    );
                  },
                  child: const Text('Forget Password',
                    style: TextStyle(color: MyColor.mainColor),
                  ),
                ),
                const Spacer(),
                Checkbox(activeColor:MyColor.mainColor,value: isCheckboxSelected, onChanged: (value) {
                  setState(() {
                    _userRepo.setRememberMe(value!);
                    isCheckboxSelected = value!;
                  });
                }),
                const Text('Remember me',
                  style: TextStyle(color: MyColor.grayB7),
                ),
              ]
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: _isLoading ? "Signing in..." : "Sign in",
              onTap: _handleSignIn,
              editWidth: double.infinity,
            ),
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Or Login with',
                  style: TextStyle(color: MyColor.grayB7),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                CustomIconButton(
                  text: "Facebook",
                  icon: AssetsManager.facebook,
                  onTap: () {},
                ),
                const Spacer(),
                CustomIconButton(
                  text: "Google",
                  onTap: () {},
                  icon: AssetsManager.google,
                ),
              ],
            ),
            const SizedBox(height: 50),
            Center(
              child: Column(
                children: [
                  SvgPicture.asset(AssetsManager.fingerprint),
                  const SizedBox(height: 20),
                  const Text("Use fingerprint instead?",
                    style: TextStyle(
                      color: MyColor.grayB7,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}