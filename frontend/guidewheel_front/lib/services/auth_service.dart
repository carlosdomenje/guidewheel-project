import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

enum AuthStatus { checking, authenticated, notAuthenticated }

/// Class for User Auth
/// Login, Register, Logout, Tokens
/// Just for test we code username and email.
class AuthService extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.notAuthenticated;

  final storage = const FlutterSecureStorage();
  String userEmail = '';
  String userName = '';
  String userID = '';

  AuthService();

  AuthStatus get status => authStatus;

  Future<String?> loginUser(String email, String password) async {
    var url = Uri.https('api-url.com', '/v1/api/auth/public/login');

    authStatus = AuthStatus.checking;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'usuario': email,
      'contrasena': password
    };
    try {
      userEmail = 'carlos@guidewheel.com';
      userName = 'Carlos D';
      await storage.write(value: userName, key: "name");
      await storage.write(value: userEmail, key: "email");

      authStatus = AuthStatus.authenticated;

      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<String> getUserName() async {
    return await storage.read(key: 'name') ?? '';
  }

  Future<String> getUserMail() async {
    return await storage.read(key: 'email') ?? '';
  }

  Future<bool> checkToken() async {
    String check = await readToken();

    if (check.isNotEmpty) {
      String _token = await readToken();
      userName = await getUserName();
      userEmail = await getUserMail();
      final Map<String, String> headers = <String, String>{
        "Authorization": "Bearer $_token"
      };
      var url = Uri.https('api-url.com', '/v1/api/public/user');
      final response = await http.get(url, headers: headers);
      authStatus = AuthStatus.authenticated;

      notifyListeners();
      return (response.statusCode == 200);
    } else {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> refreshToken() async {
    var url = Uri.https('api-url.com', '/v1/api/auth/refresh');
    if (await (checkToken())) {
      return false;
    } else {
      String _token = await readToken();
      final Map<String, String> headers = <String, String>{
        "Authorization": "Bearer $_token"
      };
      final response = await http.patch(url, headers: headers);
      return (response.statusCode == 200);
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
    //await storage.delete(key: 'userID');
    return;
  }

  Future changeEmail(String current, String newEmail, String pass) async {
    var urlServer = Uri.https('api-url.com', '/v1/api/public/user/email');
    try {
      final Map<String, dynamic> body = <String, dynamic>{
        "email": newEmail,
        "email-check": current,
        "pass-check": pass,
      };
      String _token = await readToken();

      final Map<String, String> headers = <String, String>{
        "Authorization": "Bearer $_token"
      };
      final response = await http.post(urlServer, body: body, headers: headers);

      if (response.statusCode == 226) {
        return 'true';
      } else {
        return (json.decode(response.body))[0].toString();
      }
    } catch (e) {
      return 'Error al cambiar el email';
    }
  }

  Future<String> changePassword(String newPassword, String oldPassword) async {
    var urlServer = Uri.https('api-url.com', '/v1/api/public/user/pass');
    try {
      final Map<String, dynamic> body = <String, dynamic>{
        "pass": newPassword,
        "pass-check": oldPassword,
      };
      String _token = await readToken();
      final Map<String, String> headers = <String, String>{
        "Authorization": "Bearer $_token"
      };
      final response = await http.post(urlServer, body: body, headers: headers);

      if (response.statusCode == 226) {
        return 'true';
      } else {
        return json.decode(response.body)[0];
      }
    } catch (e) {
      return 'Error en el servidor.';
    }
  }

  Future<String> changeUsername(String newName, String pass) async {
    var urlServer = Uri.https('api-url.com', '/v1/api/public/user/name');

    try {
      final Map<String, dynamic> body = <String, dynamic>{
        "username": newName,
        "pass-check": pass,
      };
      String _token = await readToken();
      final Map<String, String> headers = <String, String>{
        "Authorization": "Bearer $_token"
      };
      final response = await http.post(urlServer, body: body, headers: headers);
      if (response.statusCode == 226) {
        return 'true';
      } else {
        return response.body;
      }
    } catch (e) {
      return 'Ha ocurrido un error en el servidor';
    }
  }
}
