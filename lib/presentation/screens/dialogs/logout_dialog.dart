import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogout;
  final VoidCallback onUnregister;

  const LogoutDialog({super.key, required this.onLogout, required this.onUnregister});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: SizedBox(
        width: 320,
        height: 187,
        child: Stack(
          children: [
            Positioned(
              left: 24,
              top: 24,
              child: Image.asset('assets/images/logout.png', width: 24, height: 24),
            ),
            const Positioned(
              left: 0,
              right: 0,
              top: 26,
              child: Text(
                'Sign Out',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF8E8E93),
                ),
              ),
            ),
            Positioned(
              right: 23,
              top: 26,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.cancel, size: 18, color: Color(0xFFEB5757)),
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              top: 72,
              child: Text.rich(
                TextSpan(
                  text: 'Do you want ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF8E8E93)),
                  children: [
                    TextSpan(text: 'unregister', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' or '),
                    TextSpan(text: 'logout', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '?'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              left: 24,
              top: 124,
              child: SizedBox(
                width: 120,
                height: 32,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onUnregister();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFEB5757),
                    side: const BorderSide(color: Color(0xFFEB5757)),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'UnRegister',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 31,
              top: 124,
              child: SizedBox(
                width: 120,
                height: 32,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onLogout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEB5757),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
