import 'package:mycontact/data/model/user.dart';
import 'package:mycontact/data/repository/auth_repository.dart';
import 'package:mycontact/data/stroge/shared_manager.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _shared = SharedManager.instance;

  @override
  Future<bool> login(String username, String password) async {
    final user = _shared.getUser(username);
    if (user == null || user.password != password) return false;
    await _shared.saveCurrentUsername(username);
    return true;
  }

  @override
  Future<bool> register(String username, String password) async {
    if (_shared.getUser(username) != null) return false;
    await _shared.saveUser(User(username: username, password: password));
    await _shared.saveCurrentUsername(username);
    return true;
  }

  @override
  Future<void> logout() async {
    await _shared.clearCurrentUsername();
  }

  @override
  Future<void> deleteAccount() async {
    final username = _shared.getCurrentUsername();
    if (username == null) return;
    await _shared.removeContacts(username);
    await _shared.removeUser(username);
    await _shared.clearCurrentUsername();
  }

  @override
  User? getCurrentUser() {
    final username = _shared.getCurrentUsername();
    if (username == null) return null;
    return _shared.getUser(username);
  }

  @override
  bool isLoggedIn() {
    return getCurrentUser() != null;
  }
}
