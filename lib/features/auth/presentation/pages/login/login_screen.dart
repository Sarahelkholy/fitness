import 'package:fitness/core/shared_widgets/custom_button.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/features/auth/presentation/pages/forget_password/password_enter_email_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            const Text(
              'Welcome to fitness app login Screen',
              style: TextStyle(color: Colors.white),
            ),
            CustomButton(title: 'Sign In', onPressed: () {}),
            CustomButton(title: 'Register', onPressed: () {}),
            CustomButton(
              title: 'Forget Password',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgetPasswordScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
