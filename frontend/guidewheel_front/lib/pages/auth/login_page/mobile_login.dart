import 'package:flutter/material.dart';

import '../forms/login_form.dart';

class MobileLoginPage extends StatelessWidget {
  const MobileLoginPage({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            Center(
              child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 180, maxWidth: 450),
                  child: Image.asset(
                    'assets/images/guidewheel.png',
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(width: size.width * 0.95, child: const LoginForm()),
          ],
        ),
      ),
    );
  }
}
