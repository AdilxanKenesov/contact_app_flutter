import 'package:flutter/material.dart';
import 'package:mycontact/data/model/contact.dart';
import 'package:mycontact/presentation/widgets/input_field.dart';
import 'package:mycontact/presentation/widgets/main_button.dart';

class UpdateContactScreen extends StatefulWidget {
  final Contact contact;

  const UpdateContactScreen({super.key, required this.contact});

  @override
  State<UpdateContactScreen> createState() => _UpdateContactScreenState();
}

class _UpdateContactScreenState extends State<UpdateContactScreen> {
  late final nameController = TextEditingController(text: widget.contact.name);
  late final phoneController = TextEditingController(text: widget.contact.phone);

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
                InputField(
                  hint: 'Phone',
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 51),
                MainButton(
                  text: 'Update',
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
