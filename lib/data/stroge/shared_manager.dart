import 'dart:convert';

import 'package:mycontact/data/model/contact.dart';
import 'package:mycontact/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedManager {
  SharedManager._();

  static final SharedManager instance = SharedManager._();

  static const _usersKey = 'users';
  static const _currentUserKey = 'current_user';
  static const _contactsKey = 'contacts_';

  late SharedPreferences _pref;

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  List<User> getUsers() {
    final data = _pref.getString(_usersKey);
    if (data == null) return [];
    final List list = jsonDecode(data);
    return list.map((e) => User.fromJson(e)).toList();
  }

  Future<void> saveUsers(List<User> users) async {
    final data = jsonEncode(users.map((e) => e.toJson()).toList());
    await _pref.setString(_usersKey, data);
  }

  User? getUser(String username) {
    for (final user in getUsers()) {
      if (user.username == username) return user;
    }
    return null;
  }

  Future<void> saveUser(User user) async {
    final users = getUsers();
    users.removeWhere((e) => e.username == user.username);
    users.add(user);
    await saveUsers(users);
  }

  Future<void> removeUser(String username) async {
    final users = getUsers();
    users.removeWhere((e) => e.username == username);
    await saveUsers(users);
  }

  String? getCurrentUsername() {
    return _pref.getString(_currentUserKey);
  }

  Future<void> saveCurrentUsername(String username) async {
    await _pref.setString(_currentUserKey, username);
  }

  Future<void> clearCurrentUsername() async {
    await _pref.remove(_currentUserKey);
  }

  List<Contact> getContacts(String username) {
    final data = _pref.getString(_contactsKey + username);
    if (data == null) return [];
    final List list = jsonDecode(data);
    return list.map((e) => Contact.fromJson(e)).toList();
  }

  Future<void> saveContacts(String username, List<Contact> contacts) async {
    final data = jsonEncode(contacts.map((e) => e.toJson()).toList());
    await _pref.setString(_contactsKey + username, data);
  }

  Future<void> removeContacts(String username) async {
    await _pref.remove(_contactsKey + username);
  }
}
