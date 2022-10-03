import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCardWidget extends StatelessWidget {
  InfoCardWidget(
      {Key? key,
      required this.size,
      required this.title,
      required this.value,
      required this.icon,
      this.iconSize = 30,
      this.titleSize = 20,
      this.valueSize = 15,
      required this.iconColor})
      : super(key: key);

  final Size size;
  final String title;
  double titleSize;
  final String value;
  double valueSize;
  final IconData icon;
  double iconSize;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      elevation: 20,
      child: SizedBox(
        width: size.width * 0.16,
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),
            SizedBox(
              height: 10,
              width: size.width * 0.4,
            ),
            Text(title,
                style: GoogleFonts.roboto(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w200,
                )),
          ],
        ),
      ),
    );
  }
}
