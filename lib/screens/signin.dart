import 'package:flutter/material.dart';
import 'package:ristoply_app/widgets/signin&login/signin_widgets.dart';

class Signin extends StatelessWidget {
  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        Container(
          alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width,
          height: 297,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets_images/signin_background.png'),
                fit: BoxFit.cover),
          ),),
          Container(
            padding: const EdgeInsets.only(top: 200),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SigninWidgets(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
