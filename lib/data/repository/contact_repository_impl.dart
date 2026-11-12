import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mycontact/data/model/contact.dart';
import 'package:mycontact/data/repository/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _contacts {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('contacts');
  }

  @override
  Stream<List<Contact>> getContacts() {
    return _contacts.orderBy('createdAt').snapshots().map(
          (snapshot) => snapshot.docs.map((e) => Contact.fromJson(e.id, e.data())).toList(),
        );
  }

  @override
  Future<void> addContact(String name, String phone) async {
    await _contacts.add({
      'name': name,
      'phone': phone,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Future<void> updateContact(Contact contact) async {
    await _contacts.doc(contact.id).update(contact.toJson());
  }

  @override
  Future<void> deleteContact(String id) async {
    await _contacts.doc(id).delete();
  }
}
