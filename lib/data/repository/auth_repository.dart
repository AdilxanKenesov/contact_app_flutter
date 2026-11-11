import 'package:mycontact/data/model/user.dart';

abstract interface class AuthRepository {
  Future<bool> login(String username, String password);
  Future<bool> register(String username, String password);
  Future<void> logout();
  Future<void> deleteAccount();
  User? getCurrentUser();
  bool isLoggedIn();
}
