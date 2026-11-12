import 'package:flutter/material.dart';
import 'package:mycontact/data/model/contact.dart';
import 'package:mycontact/data/repository/contact_repository_impl.dart';
import 'package:mycontact/presentation/widgets/input_field.dart';
import 'package:mycontact/presentation/widgets/main_button.dart';
import 'package:mycontact/utils/validator.dart';

class UpdateContactScreen extends StatefulWidget {
  final Contact contact;

  const UpdateContactScreen({super.key, required this.contact});

  @override
  State<UpdateContactScreen> createState() => _UpdateContactScreenState();
}

class _UpdateContactScreenState extends State<UpdateContactScreen> {
  late final nameController = TextEditingController(text: widget.contact.name);
  late final phoneController = TextEditingController(text: widget.contact.phone);
  final contactRepository = ContactRepositoryImpl();

  Future<String?> checkSamePhone(String phone) async {
    final contacts = await contactRepository.getContacts().first;
    final exists = contacts.any((e) => e.phone == phone && e.id != widget.contact.id);
    return exists ? 'This phone already exists' : null;
  }

  Future<void> update() async {
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
    await contactRepository.updateContact(widget.contact.copyWith(name: name, phone: phone));
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
                const SizedBox(height: 79),
                Image.asset('assets/images/update_logo.png', width: 141, height: 141),
                const SizedBox(height: 93),
                InputField(hint: 'Name', controller: nameController),
                const SizedBox(height: 24),
                InputField(hint: 'Phone', controller: phoneController, isPhone: true),
                const SizedBox(height: 51),
                MainButton(
                  text: 'Update',
                  onTap: update,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
