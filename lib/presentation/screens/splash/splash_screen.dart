import 'package:flutter/material.dart';
import 'package:mycontact/data/repository/auth_repository_impl.dart';
import 'package:mycontact/presentation/screens/home/home_screen.dart';
import 'package:mycontact/presentation/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final isLoggedIn = AuthRepositoryImpl().isLoggedIn();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => isLoggedIn ? const HomeScreen() : const LoginScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Image.asset('assets/images/splash_logo.png', width: 188, height: 174),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Center(
              child: RotationTransition(
                turns: controller,
                child: Image.asset('assets/images/loading.png', width: 24, height: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
