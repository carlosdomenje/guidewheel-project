import 'package:flutter/material.dart';

class CustomBigButton extends StatelessWidget {
  final Function onPress;
  final Color color1;
  final Color color2;
  final IconData icon;
  final String texto;
  final String texto2;

  const CustomBigButton(
      {Key? key,
      required this.onPress,
      this.color1 = Colors.blue,
      this.color2 = Colors.blueAccent,
      required this.icon,
      required this.texto,
      required this.texto2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Stack(
        children: <Widget>[
          BigButtonBackground(
            icon: icon,
            color1: color1,
            color2: color2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 140,
                width: 30,
              ),
              Icon(
                icon,
                size: 45,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(texto,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Text(texto2,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.normal)),
                ],
              )),
              const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(
                width: 25,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BigButtonBackground extends StatelessWidget {
  final Color color1;
  final Color color2;
  final IconData icon;

  const BigButtonBackground(
      {this.color1 = Colors.blue,
      this.color2 = Colors.blueAccent,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Icon(
                this.icon,
                size: 150,
                color: Colors.white.withOpacity(0.2),
              ),
              right: -20,
              top: -20,
            ),
          ],
        ),
      ),
      height: 120.0,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [this.color1, this.color2],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10)
          ]),
    );
  }
}
