import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCardExtraWidget extends StatelessWidget {
  const InfoCardExtraWidget(
      {Key? key,
      required this.size,
      required this.title,
      required this.value,
      required this.icon,
      required this.iconColor})
      : super(key: key);
  final Size size;
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      elevation: 30,
      child: Container(
        width: size.width * 0.2,
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 30,
              color: iconColor,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('$title',
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('$value',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            )

            // SizedBox(
            //   height: 10,
            //   width: size.width * 0.4,
            // ),
            // Text('$value',
            //     style: GoogleFonts.roboto(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //     ))
          ],
        ),
      ),
    );
  }
}
