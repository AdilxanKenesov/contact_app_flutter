import 'package:flutter/material.dart';
import 'package:mycontact/data/repository/auth_repository_impl.dart';
import 'package:mycontact/presentation/screens/home/home_screen.dart';
import 'package:mycontact/presentation/screens/register/register_screen.dart';
import 'package:mycontact/presentation/widgets/input_field.dart';
import 'package:mycontact/presentation/widgets/main_button.dart';
import 'package:mycontact/utils/phone_formatter.dart';
import 'package:mycontact/utils/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController(text: PhoneFormatter.prefix);
  final passwordController = TextEditingController();
  final authRepository = AuthRepositoryImpl();

  Future<void> login() async {
    final phone = phoneController.text;
    final password = passwordController.text;
    final error = Validator.phone(phone) ?? Validator.password(password);
    if (error != null) {
      showMessage(error);
      return;
    }
    bool success;
    try {
      success = await authRepository.login(phone, password);
    } catch (e) {
      showMessage('Something went wrong. Check your internet connection');
      return;
    }
    if (!mounted) return;
    if (!success) {
      showMessage('Phone or password is wrong');
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
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
                const SizedBox(height: 75),
                Image.asset('assets/images/login_logo.png', width: 188, height: 174),
                const SizedBox(height: 64),
                InputField(hint: 'Phone', controller: phoneController, isPhone: true),
                const SizedBox(height: 24),
                InputField(hint: 'Password', controller: passwordController, isPassword: true),
                const SizedBox(height: 55),
                MainButton(
                  text: 'Log In',
                  onTap: login,
                ),
                const SizedBox(height: 27),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: 'Don’t have an account yet? ',
                      style: TextStyle(fontSize: 14, color: Color(0xFF8E8E93)),
                      children: [
                        TextSpan(
                          text: 'Sign up here',
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
