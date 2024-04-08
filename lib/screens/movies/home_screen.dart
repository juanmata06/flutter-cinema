import "package:flutter/material.dart";
import "package:flutter_cinema/config/constants/enviroment.dart";

class HomeScreen extends StatelessWidget {
  static const route = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Enviroment.mdbKey),
      ),
    );
  }
}
