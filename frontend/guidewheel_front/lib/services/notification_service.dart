import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String message) {
    final snackBar = SnackBar(
        content: Text(
      message,
      style: GoogleFonts.roboto(fontSize: 16),
    ));
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
