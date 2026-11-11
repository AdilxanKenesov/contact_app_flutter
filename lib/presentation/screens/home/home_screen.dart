import 'package:flutter/material.dart';
import 'package:mycontact/data/model/contact.dart';
import 'package:mycontact/presentation/screens/dialogs/delete_dialog.dart';
import 'package:mycontact/presentation/screens/dialogs/logout_dialog.dart';
import 'package:mycontact/presentation/screens/home/add_contact_screen.dart';
import 'package:mycontact/presentation/screens/home/update_contact_screen.dart';
import 'package:mycontact/presentation/screens/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Contact> contacts = [];

  void openLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) => LogoutDialog(
        onLogout: goToLogin,
        onUnregister: goToLogin,
      ),
    );
  }

  void goToLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  void openDeleteDialog(Contact contact) {
    showDialog(
      context: context,
      builder: (_) => DeleteDialog(
        name: contact.name,
        onDelete: () => setState(() => contacts.remove(contact)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Row(
                    children: [
                      const Text(
                        'My Contacts',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: openLogoutDialog,
                        child: Image.asset('assets/images/logout.png', width: 32, height: 32),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: contacts.length,
                    itemBuilder: (context, index) => contactItem(contacts[index]),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 20,
              bottom: 24,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddContactScreen()),
                  );
                },
                child: Image.asset('assets/images/add_button.png', width: 68, height: 68),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget contactItem(Contact contact) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: Row(
            children: [
              const SizedBox(width: 21),
              const CircleAvatar(
                radius: 19.5,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontVariations: [FontVariation.weight(600)],
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      contact.phone,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontVariations: [FontVariation.weight(600)],
                        color: Color(0x80333333),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                color: Colors.white,
                onSelected: (value) {
                  if (value == 'update') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => UpdateContactScreen(contact: contact)),
                    );
                  } else {
                    openDeleteDialog(contact);
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'update', child: Text('Update')),
                  PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
                child: const Padding(
                  padding: EdgeInsets.only(left: 12, right: 24, top: 12, bottom: 12),
                  child: Row(
                    children: [
                      Dot(),
                      SizedBox(width: 4),
                      Dot(),
                      SizedBox(width: 4),
                      Dot(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          color: const Color(0xFFE0E0E0),
        ),
      ],
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      decoration: const BoxDecoration(color: Color(0xFFBDBDBD), shape: BoxShape.circle),
    );
  }
}
