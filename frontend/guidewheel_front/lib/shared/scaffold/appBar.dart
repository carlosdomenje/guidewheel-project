import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guidewheel_front/shared/scaffold/drawer.dart';

AppBar appBar(
    Size size, GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) {
  return AppBar(
    title: const Text('DATA'),
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: () {
          context.go('/add_tab');
        },
        icon: const Icon(Icons.add),
        splashRadius: 10,
      ),
      const SizedBox(
        width: 10,
      ),
      IconButton(
        onPressed: () {
          //openDrawer(scaffoldKey);
        },
        icon: const Icon(Icons.menu),
        splashRadius: 10,
      ),
      const SizedBox(
        width: 20,
      )
    ],
  );
}
