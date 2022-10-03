import 'package:flutter/material.dart';
import 'package:guidewheel_front/routes/routes.dart';
import 'package:guidewheel_front/services/auth_service.dart';
import 'package:guidewheel_front/services/guidewheel_service.dart';
import 'package:guidewheel_front/services/notification_service.dart';
import 'package:provider/provider.dart';

import 'providers/theme_changer_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GuidewheelService()),
        ChangeNotifierProvider(
          create: (_) => ThemeChanger(false),
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authService = AuthService();

  late final _router = routesNav(authService);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return ChangeNotifierProvider<AuthService>.value(
      value: authService,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild!.unfocus();
          }
        },
        child: MaterialApp.router(
            routeInformationParser: _router.routeInformationParser,
            routerDelegate: _router.routerDelegate,
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: NotificationService.messengerKey,
            title: 'GUIDEWHEEL',
            theme: currentTheme),
      ),
    );
  }
}
