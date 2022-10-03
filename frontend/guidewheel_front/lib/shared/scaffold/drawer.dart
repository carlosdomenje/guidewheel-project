import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:guidewheel_front/services/auth_service.dart';
import 'package:guidewheel_front/shared/scaffold/menu_item.dart';

Drawer drawerMenu(AuthService authService, BuildContext context) {
  return Drawer(
      child: Container(
    decoration: _buildDrawerDecoration(),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 250,
          width: double.infinity,
          color: const Color(0xFF424242),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 45,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60.0),
                  child: Image.asset('assets/images/profile-icon.png'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(authService.userName,
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.white70,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(authService.userEmail,
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.white70,
                  )),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        MenuItemCustom(
            text: 'Account',
            icon: Icons.account_box_rounded,
            isActive: false,
            onPressed: () {}),
        MenuItemCustom(
            text: 'Data',
            icon: Icons.settings,
            isActive: false,
            onPressed: () {}),
        MenuItemCustom(
            text: 'Logout',
            icon: Icons.exit_to_app_outlined,
            isActive: false,
            onPressed: () => {
                  authService.logout(),
                }),
      ],
    ),
  ));
}

BoxDecoration _buildDrawerDecoration() {
  return const BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.black, spreadRadius: 0.8, blurRadius: 0.9)
      ],
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF000000),
            Color(0xFF434343),
          ]));
}

void openDrawer(GlobalKey<ScaffoldState> scaffoldKey) {
  scaffoldKey.currentState!.openDrawer();
}
