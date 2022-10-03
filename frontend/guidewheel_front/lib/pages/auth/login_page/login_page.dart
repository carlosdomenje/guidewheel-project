import 'package:flutter/material.dart';
import 'package:guidewheel_front/pages/auth/login_page/mobile_login.dart';
import 'package:guidewheel_front/pages/auth/login_page/tablet_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black87,
        body: (size.width < 700)
            ? MobileLoginPage(size: size)
            : WebTabletLoginPage(size: size));
  }
}
