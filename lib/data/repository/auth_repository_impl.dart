import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:mycontact/data/model/user.dart';
import 'package:mycontact/data/repository/auth_repository.dart';
import 'package:mycontact/utils/phone_formatter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String _email(String phone) {
    return '${phone.replaceAll(RegExp(r'\D'), '')}@mycontact.app';
  }

  @override
  Future<bool> login(String phone, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: _email(phone), password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential' || e.code == 'user-not-found' || e.code == 'wrong-password') {
        return false;
      }
      rethrow;
    }
  }

  @override
  Future<bool> register(String phone, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: _email(phone),
        password: password,
      );
      await _firestore.collection('users').doc(result.user!.uid).set(User(phone: phone).toJson());
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') return false;
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null) return;
    final userDoc = _firestore.collection('users').doc(user.uid);
    final contacts = await userDoc.collection('contacts').get();
    final batch = _firestore.batch();
    for (final doc in contacts.docs) {
      batch.delete(doc.reference);
    }
    batch.delete(userDoc);
    await batch.commit();
    await user.delete();
  }

  @override
  User? getCurrentUser() {
    final email = _auth.currentUser?.email;
    if (email == null) return null;
    final digits = email.split('@').first;
    return User(phone: PhoneFormatter.format(digits.substring(3)));
  }

  @override
  bool isLoggedIn() {
    return _auth.currentUser != null;
  }
}
