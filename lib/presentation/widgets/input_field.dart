import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;

  const InputField({
    super.key,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      height: 58,
      padding: const EdgeInsets.only(left: 29, right: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFF8E8E93), width: 0.5),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), offset: Offset(0, 1), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              obscureText: widget.isPassword && hidden,
              keyboardType: widget.keyboardType,
              style: const TextStyle(fontSize: 16, color: Color(0xFF8E8E93)),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: const TextStyle(fontSize: 16, color: Color(0x803C3C43)),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              if (widget.isPassword) {
                setState(() => hidden = !hidden);
              } else {
                widget.controller.clear();
              }
            },
            child: widget.isPassword
                ? Icon(
                    hidden ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                    color: const Color(0xFF8E8E93),
                  )
                : const Icon(Icons.cancel, size: 19, color: Color(0xFF8E8E93)),
          ),
        ],
      ),
    );
  }
}
