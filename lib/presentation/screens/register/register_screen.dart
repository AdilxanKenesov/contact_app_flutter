import 'package:flutter/material.dart';
import 'package:mycontact/data/repository/auth_repository_impl.dart';
import 'package:mycontact/presentation/screens/home/home_screen.dart';
import 'package:mycontact/presentation/widgets/input_field.dart';
import 'package:mycontact/presentation/widgets/main_button.dart';
import 'package:mycontact/utils/phone_formatter.dart';
import 'package:mycontact/utils/validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final phoneController = TextEditingController(text: PhoneFormatter.prefix);
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final authRepository = AuthRepositoryImpl();

  Future<void> register() async {
    final phone = phoneController.text;
    final password = passwordController.text;
    final error = Validator.phone(phone) ?? Validator.password(password);
    if (error != null) {
      showMessage(error);
      return;
    }
    if (password != confirmController.text) {
      showMessage('Passwords do not match');
      return;
    }
    bool success;
    try {
      success = await authRepository.register(phone, password);
    } catch (e) {
      showMessage('Something went wrong. Check your internet connection');
      return;
    }
    if (!mounted) return;
    if (!success) {
      showMessage('This phone is already registered');
      return;
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  void showMessage(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  void dispose() {
    phoneController.dispose();
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
                InputField(hint: 'Phone', controller: phoneController, isPhone: true),
                const SizedBox(height: 24),
                InputField(hint: 'Password', controller: passwordController, isPassword: true),
                const SizedBox(height: 24),
                InputField(hint: 'Confirm Password', controller: confirmController, isPassword: true),
                const SizedBox(height: 44),
                MainButton(
                  text: 'Register',
                  onTap: register,
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
