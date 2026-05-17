import 'package:flutter/material.dart';

class IdleView extends StatelessWidget {
  const IdleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Padding(
          padding: const EdgeInsets.only(top: 90.0),
          child: Center(
            child: Image.asset(
              'assets/images/italia.png',
              scale: 0.75,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 50, left: 50, top: 4),
          child: Text(
            "Inizia a cercare una città per scoprire le cucine disponibili!",
            style: TextStyle(color: Colors.grey, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}