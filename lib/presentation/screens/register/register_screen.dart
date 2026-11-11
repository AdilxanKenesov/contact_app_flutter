import 'package:flutter/material.dart';
import 'package:mycontact/presentation/screens/home/home_screen.dart';
import 'package:mycontact/presentation/widgets/input_field.dart';
import 'package:mycontact/presentation/widgets/main_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset('assets/images/register_logo.png', width: 141, height: 130),
                const SizedBox(height: 71),
                InputField(hint: 'Username', controller: usernameController),
                const SizedBox(height: 24),
                InputField(hint: 'Password', controller: passwordController, isPassword: true),
                const SizedBox(height: 24),
                InputField(hint: 'Confirm Password', controller: confirmController, isPassword: true),
                const SizedBox(height: 44),
                MainButton(
                  text: 'Register',
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (route) => false,
                    );
                  },
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text.rich(
                    TextSpan(
                      text: 'Do you have an account? ',
                      style: TextStyle(fontSize: 14, color: Color(0xFF8E8E93)),
                      children: [
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
