import 'package:flutter/material.dart';
import 'package:ristoply_app/widgets/signin&login/login_widgets.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            height: 297,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage('assets/assets_images/login_background.jpeg'),
                  fit: BoxFit.fitWidth),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 200),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginWidgets(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
