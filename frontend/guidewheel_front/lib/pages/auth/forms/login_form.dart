import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guidewheel_front/providers/login_provider.dart';

import 'package:provider/provider.dart';

import '../../../services/auth_service.dart';
import '../../../services/notification_service.dart';
import '../../../shared/inputs/custom_inputs.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _checked = false;
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      child: Builder(builder: (context) {
        final loginProvider =
            Provider.of<LoginFormProvider>(context, listen: true);
        _checked = loginProvider.remember;
        _userController.text = loginProvider.user;
        _passController.text = loginProvider.pass;

        return Form(
          key: loginProvider.loginKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: TextFormField(
                  validator: (value) {
                    if (value != null) {
                      return null;
                    }

                    return 'El user es inválido';
                  },
                  controller: _userController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.name,
                  decoration: CustomInputs.customInputDecoration(
                      hint: 'Guidewheel', label: 'User', icon: Icons.person),
                  onChanged: (value) {
                    loginProvider.user = value;
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: TextFormField(
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    } else {
                      return 'La contraseña es inválida';
                    }
                  },
                  obscureText: true,
                  controller: _passController,
                  keyboardType: TextInputType.visiblePassword,
                  style: const TextStyle(color: Colors.white),
                  decoration: CustomInputs.customInputDecoration(
                      hint: '***********',
                      label: 'Password',
                      icon: Icons.password_outlined),
                  onChanged: (value) {
                    loginProvider.pass = value;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Theme(
                data: ThemeData(
                    unselectedWidgetColor: Colors.pink.withOpacity(0.9)),
                child: CheckboxListTile(
                    checkColor: Colors.white,
                    activeColor: Colors.pinkAccent,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    title: Text(
                      'Remember me',
                      style: GoogleFonts.roboto(
                          color: Colors.white.withOpacity(0.9), fontSize: 18),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _checked,
                    onChanged: (value) {
                      setState(() {
                        loginProvider.remember = value!;
                      });
                    }),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: (loginProvider.isLoading)
                    ? null
                    : () async {
                        if (loginProvider.validateForm()) {
                          loginProvider.isLoading = true;
                          if (_checked) {
                            loginProvider.saveUser(loginProvider.user,
                                loginProvider.pass, _checked.toString());
                          } else {
                            loginProvider.deleteUser();
                          }
                          FocusScope.of(context).unfocus();
                          //final authService = AuthService();
                          /** Con el context.read y la clase, le aviso a todos los notifiers que estan escuchando  */
                          final String? resp = await context
                              .read<AuthService>()
                              .loginUser(
                                  loginProvider.user, loginProvider.pass);
                          if (resp == null) {
                            loginProvider.isLoading = false;
                            //Navigator.pushReplacementNamed(context, '/');
                          } else {
                            loginProvider.isLoading = false;

                            NotificationService.showSnackBar(resp);
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.withOpacity(0.8),
                    fixedSize: const Size.fromWidth(300),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  loginProvider.isLoading ? 'ESPERE' : 'LOGIN',
                  style: GoogleFonts.roboto(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      }),
    );
  }
}
