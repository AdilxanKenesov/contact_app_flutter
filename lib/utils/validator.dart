class Validator {
  static String? phone(String text) {
    if (!RegExp(r'^\+998 \d{2} \d{3} \d{2} \d{2}$').hasMatch(text)) {
      return 'Enter full phone number';
    }
    return null;
  }

  static String? password(String text) {
    if (text.isEmpty) return 'Enter password';
    if (text.contains(' ')) return 'Password must not contain spaces';
    if (text.length < 8) return 'Password must be at least 8 characters';
    if (text.length > 20) return 'Password must be at most 20 characters';
    if (!RegExp(r'[a-zA-Z]').hasMatch(text)) return 'Password must contain a letter';
    if (!RegExp(r'\d').hasMatch(text)) return 'Password must contain a number';
    return null;
  }

  static String? name(String text) {
    final name = text.trim();
    if (name.isEmpty) return 'Enter name';
    if (name.length < 2) return 'Name is too short';
    if (name.length > 30) return 'Name is too long';
    if (!RegExp(r"^[\p{L} '\-]+$", unicode: true).hasMatch(name)) {
      return 'Name must contain only letters';
    }
    return null;
  }
}
