import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeChanger extends ChangeNotifier {
  bool _currTheme = false;

  ThemeData _currentTheme = ThemeData.light();

  bool get currTheme => _currTheme;
  ThemeData get currentTheme => _currentTheme;

  ThemeChanger(bool theme) {
    if (!theme) {
      _currTheme = false;

      _currentTheme = ThemeData(
        brightness: Brightness.dark,
        hoverColor: Colors.transparent,

        //textTheme: GoogleFonts.robotoTextTheme(),
        appBarTheme: const AppBarTheme(
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            color: Color(0xFF424242)),
        progressIndicatorTheme:
            ProgressIndicatorThemeData(color: Colors.white.withOpacity(0.7)),
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.pink),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            elevation: 0,
            backgroundColor: Color(0xFF424242),
            selectedItemColor: Colors.pinkAccent),
      );
    }
    notifyListeners();
  }

  set currTheme(bool value) {
    _currTheme = value;

    if (!value) {
      _currTheme = false;
      _currentTheme = ThemeData(
          brightness: Brightness.light,
          hoverColor: Colors.red,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color(0xFFf05545),
              unselectedItemColor: Colors.grey,
              elevation: 0,
              selectedItemColor: Colors.white),
          //textTheme: GoogleFonts.robotoTextTheme(),
          scaffoldBackgroundColor: Colors.grey[100],
          progressIndicatorTheme:
              const ProgressIndicatorThemeData(color: Color(0xFF484848)),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              elevation: 15, backgroundColor: Colors.pink),
          appBarTheme: const AppBarTheme(
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              color: Colors.black));
    }
    notifyListeners();
  }
}
