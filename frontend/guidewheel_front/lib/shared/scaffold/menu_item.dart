import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItemCustom extends StatefulWidget {
  const MenuItemCustom(
      {Key? key,
      required this.text,
      required this.icon,
      required this.isActive,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool isActive;
  final Function onPressed;

  @override
  _MenuItemCustomState createState() => _MenuItemCustomState();
}

class _MenuItemCustomState extends State<MenuItemCustom> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      color: isHovered
          ? Colors.grey.withOpacity(0.98)
          : widget.isActive
              ? Colors.grey.withOpacity(0.98)
              : Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.isActive ? null : () => widget.onPressed(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    color: Colors.grey.withOpacity(0.6),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.text,
                    style:
                        GoogleFonts.roboto(fontSize: 16, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
