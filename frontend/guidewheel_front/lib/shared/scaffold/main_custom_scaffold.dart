import 'package:flutter/material.dart';
import 'package:guidewheel_front/services/auth_service.dart';
import 'package:guidewheel_front/shared/scaffold/appBar.dart';
import 'package:guidewheel_front/shared/scaffold/drawer.dart';

class CustomMainScaffold extends StatelessWidget {
  const CustomMainScaffold({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required this.authService,
    required this.size,
    required this.widget,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final AuthService authService;
  final Size size;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        //backgroundColor: Colors.grey[300],
        endDrawer: drawerMenu(authService, context),
        appBar: appBar(size, _scaffoldKey, context),
        body: widget);
  }
}
