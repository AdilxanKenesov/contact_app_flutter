import 'package:mycontact/data/model/contact.dart';
import 'package:mycontact/data/repository/contact_repository.dart';
import 'package:mycontact/data/stroge/shared_manager.dart';

class ContactRepositoryImpl implements ContactRepository {
  final _shared = SharedManager.instance;

  String get _username => _shared.getCurrentUsername() ?? '';

  @override
  List<Contact> getContacts() {
    return _shared.getContacts(_username);
  }

  @override
  Future<void> addContact(String name, String phone) async {
    final contacts = getContacts();
    contacts.add(Contact(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name,
      phone: phone,
    ));
    await _shared.saveContacts(_username, contacts);
  }

  @override
  Future<void> updateContact(Contact contact) async {
    final contacts = getContacts();
    final index = contacts.indexWhere((e) => e.id == contact.id);
    if (index == -1) return;
    contacts[index] = contact;
    await _shared.saveContacts(_username, contacts);
  }

  @override
  Future<void> deleteContact(int id) async {
    final contacts = getContacts();
    contacts.removeWhere((e) => e.id == id);
    await _shared.saveContacts(_username, contacts);
  }
}
