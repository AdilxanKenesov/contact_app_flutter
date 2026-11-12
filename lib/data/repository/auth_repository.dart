import 'package:mycontact/data/model/user.dart';

abstract interface class AuthRepository {
  Future<bool> login(String phone, String password);
  Future<bool> register(String phone, String password);
  Future<void> logout();
  Future<void> deleteAccount();
  User? getCurrentUser();
  bool isLoggedIn();
}
