import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputs {
  static InputDecoration customInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      errorStyle: const TextStyle(color: Colors.red),
      focusedErrorBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.withOpacity(0.5))),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink),
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3))),
      hintText: hint,
      labelText: label,
      icon: Icon(icon, color: Colors.pink.withOpacity(0.9)),
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
    );
  }

  static InputDecoration searchInputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration formConfigDecoration({
    required String hint,
    required String label,
    required String unity,
    required IconData icon,
  }) {
    return InputDecoration(
      //labelText: label,
      label: Text(label,
          style: GoogleFonts.roboto(
            fontSize: 15,
          )),
      icon: Icon(
        icon,
        size: 35,
      ),

      hintText: hint,
      suffixText: unity,
      //labelStyle: TextStyle(color: Colors.black87),
      hintStyle: const TextStyle(color: Colors.grey),

      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide()),
      border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3))),
    );
  }

  static InputDecoration addDeviceDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      //labelText: label,
      label: Text(label,
          style: GoogleFonts.roboto(
            fontSize: 15,
          )),
      icon: Icon(
        icon,
        size: 35,
      ),

      hintText: hint,
      //labelStyle: TextStyle(color: Colors.black87),
      hintStyle: const TextStyle(color: Colors.grey),

      focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.pink)),
      border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3))),
    );
  }
}
