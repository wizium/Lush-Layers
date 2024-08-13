import 'package:flutter/material.dart';

class SomethingWrongScreen extends StatelessWidget {
  const SomethingWrongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/5_Something Wrong.png",
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
