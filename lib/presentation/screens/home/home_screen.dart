import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mycontact/data/model/contact.dart';
import 'package:mycontact/data/repository/auth_repository_impl.dart';
import 'package:mycontact/data/repository/contact_repository_impl.dart';
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
  final authRepository = AuthRepositoryImpl();
  final contactRepository = ContactRepositoryImpl();
  List<Contact> contacts = [];
  StreamSubscription<List<Contact>>? subscription;

  @override
  void initState() {
    super.initState();
    subscription = contactRepository.getContacts().listen(
      (list) => setState(() => contacts = list),
      onError: (error) {},
    );
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void openLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) => LogoutDialog(
        onLogout: () async {
          await subscription?.cancel();
          await authRepository.logout();
          goToLogin();
        },
        onUnregister: () async {
          await subscription?.cancel();
          try {
            await authRepository.deleteAccount();
          } catch (e) {
            await authRepository.logout();
          }
          goToLogin();
        },
      ),
    );
  }

  void goToLogin() {
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  Future<bool> confirmDelete(Contact contact) async {
    var deleted = false;
    await showDialog(
      context: context,
      builder: (_) => DeleteDialog(
        name: contact.name,
        onDelete: () {
          deleted = true;
        },
      ),
    );
    return deleted;
  }

  void openUpdate(Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => UpdateContactScreen(contact: contact)),
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
    return Dismissible(
      key: ValueKey(contact.id),
      background: swipeBackground(
        color: const Color(0xFF8E8E93),
        icon: Icons.edit,
        alignment: Alignment.centerLeft,
      ),
      secondaryBackground: swipeBackground(
        color: const Color(0xFFEB5757),
        icon: Icons.delete,
        alignment: Alignment.centerRight,
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          openUpdate(contact);
          return false;
        }
        return confirmDelete(contact);
      },
      onDismissed: (direction) {
        setState(() => contacts.remove(contact));
        contactRepository.deleteContact(contact.id);
      },
      child: ColoredBox(color: Colors.white, child: contactRow(contact)),
    );
  }

  Widget swipeBackground({
    required Color color,
    required IconData icon,
    required Alignment alignment,
  }) {
    return Container(
      color: color,
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Icon(icon, color: Colors.white),
    );
  }

  Widget contactRow(Contact contact) {
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
                onSelected: (value) async {
                  if (value == 'update') {
                    openUpdate(contact);
                  } else if (await confirmDelete(contact)) {
                    await contactRepository.deleteContact(contact.id);
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
