import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String name;
  final VoidCallback onDelete;

  const DeleteDialog({super.key, required this.name, required this.onDelete});

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
              left: 28,
              top: 33,
              child: Image.asset('assets/images/delete.png', width: 24, height: 24),
            ),
            const Positioned(
              left: 81,
              top: 34,
              child: Text(
                'Delete contact',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF8E8E93),
                ),
              ),
            ),
            Positioned(
              left: 82,
              right: 16,
              top: 72,
              child: Text.rich(
                TextSpan(
                  text: 'Do you want delete ',
                  style: const TextStyle(fontSize: 16, color: Color(0xFF8E8E93)),
                  children: [
                    TextSpan(text: name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: '?'),
                  ],
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
            Positioned(
              right: 15,
              bottom: 19,
              child: SizedBox(
                width: 120,
                height: 32,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onDelete();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEB5757),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'Delete',
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
