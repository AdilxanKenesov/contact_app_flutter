import 'package:mycontact/data/model/contact.dart';

abstract interface class ContactRepository {
  List<Contact> getContacts();
  Future<void> addContact(String name, String phone);
  Future<void> updateContact(Contact contact);
  Future<void> deleteContact(int id);
}
