import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guidewheel_front/pages/auth/login_page/login_page.dart';
import 'package:guidewheel_front/pages/home/home_page.dart';

import '../services/auth_service.dart';

/// Routes for differents pages
/// Login Page: for login user
/// Home Page: Visualize data of the day
GoRouter routesNav(AuthService authService) {
  return GoRouter(
      urlPathStrategy: UrlPathStrategy.path,
      routes: [
        GoRoute(
            path: '/',
            name: 'home',
            pageBuilder: (context, state) => CustomTransitionPage(
                child: const HomePage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                transitionDuration: const Duration(milliseconds: 500))),
        GoRoute(
            path: '/login',
            name: 'login',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: LoginPage())),
      ],
      redirect: (state) {
        final userLogged = authService.authStatus;

        final isInLogginPage = state.subloc == '/login';

        if (userLogged != AuthStatus.authenticated) {
          if (isInLogginPage) {
            return null;
          } else {
            return '/login';
          }
        }

        if (isInLogginPage) return '/';

        return null;
      },
      refreshListenable: authService);
}
