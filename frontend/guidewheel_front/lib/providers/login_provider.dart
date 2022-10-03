import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  String user = '';
  String pass = '';
  bool remember = false;

  bool _isLoading = false;

  final storage = const FlutterSecureStorage();

  LoginFormProvider() {
    loadData();
  }

  Future<void> loadData() async {
    user = await storage.read(key: 'user') ?? '';
    pass = await storage.read(key: 'pass') ?? '';
    final status = await storage.read(key: 'checked') ?? '';
    remember = (status == 'true') ? true : false;

    notifyListeners();
  }

  bool get isLoading => _isLoading;
  set isLoading(bool state) {
    _isLoading = state;
    notifyListeners();
  }

  saveUser(String user, String pass, String checked) async {
    await storage.write(key: 'checked', value: checked);
    await storage.write(key: 'user', value: user);
    await storage.write(key: 'pass', value: pass);
  }

  deleteUser() async {
    await storage.delete(key: 'user');
    await storage.delete(key: 'pass');
    await storage.delete(key: 'checked');
  }

  bool validateForm() {
    if (loginKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
