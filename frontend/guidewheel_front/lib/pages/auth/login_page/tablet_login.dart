import 'package:flutter/material.dart';

import '../forms/login_form.dart';

class WebTabletLoginPage extends StatelessWidget {
  const WebTabletLoginPage({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            Center(
              child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 320, maxWidth: 650),
                  child: Image.asset(
                    'assets/images/guidewheel.png',
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 60),
              decoration: BoxDecoration(
                  color: const Color(0xff616161).withOpacity(0.2)),
              width: 650,
              child: const LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}
