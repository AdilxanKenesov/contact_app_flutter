import 'package:flutter/material.dart';
import 'package:mycontact/presentation/widgets/input_field.dart';
import 'package:mycontact/presentation/widgets/main_button.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

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
                InputField(
                  hint: 'Phone',
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 51),
                MainButton(
                  text: 'Add',
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
