import 'package:flutter/services.dart';

class PhoneFormatter extends TextInputFormatter {
  static const prefix = '+998 ';

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (!newValue.text.startsWith('+998')) {
      return _value(prefix);
    }

    var digits = _digits(newValue.text);
    final oldDigits = _digits(oldValue.text);
    final isDeleting = newValue.text.length < oldValue.text.length;
    if (isDeleting && digits == oldDigits && digits.isNotEmpty) {
      digits = digits.substring(0, digits.length - 1);
    }
    if (digits.length > 9) {
      digits = digits.substring(0, 9);
    }

    return _value(format(digits));
  }

  static String format(String digits) {
    var result = prefix;
    for (var i = 0; i < digits.length; i++) {
      if (i == 2 || i == 5 || i == 7) result += ' ';
      result += digits[i];
    }
    return result;
  }

  String _digits(String text) {
    if (text.length < 4) return '';
    return text.substring(4).replaceAll(RegExp(r'\D'), '');
  }

  TextEditingValue _value(String text) {
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
