import 'package:flutter/material.dart';
import 'package:mycontact/data/repository/contact_repository_impl.dart';
import 'package:mycontact/presentation/widgets/input_field.dart';
import 'package:mycontact/presentation/widgets/main_button.dart';
import 'package:mycontact/utils/phone_formatter.dart';
import 'package:mycontact/utils/validator.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController(text: PhoneFormatter.prefix);
  final contactRepository = ContactRepositoryImpl();

  Future<String?> checkSamePhone(String phone) async {
    final contacts = await contactRepository.getContacts().first;
    final exists = contacts.any((e) => e.phone == phone);
    return exists ? 'This phone already exists' : null;
  }

  Future<void> add() async {
    final name = nameController.text.trim();
    final phone = phoneController.text;
    var error = Validator.name(name) ?? Validator.phone(phone);
    error ??= await checkSamePhone(phone);
    if (!mounted) return;
    if (error != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    await contactRepository.addContact(name, phone);
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
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
                const SizedBox(height: 84),
                Image.asset('assets/images/add_logo.png', width: 141, height: 131),
                const SizedBox(height: 98),
                InputField(hint: 'Name', controller: nameController),
                const SizedBox(height: 24),
                InputField(hint: 'Phone', controller: phoneController, isPhone: true),
                const SizedBox(height: 51),
                MainButton(
                  text: 'Add',
                  onTap: add,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
