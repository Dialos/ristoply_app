import 'package:flutter/material.dart';

class Carrello extends StatelessWidget {
  const Carrello({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Il carrello è vuoto'),
      ),
    );
  }
}