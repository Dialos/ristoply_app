import 'package:flutter/material.dart';
import 'package:ristoply_app/screens/login.dart';
import 'package:ristoply_app/widgets/signin&login/recovery_widgets.dart';

class PasswordLost extends StatelessWidget {
  const PasswordLost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        mini: true,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.5),
        child: const Icon(Icons.arrow_back, color: Colors.white, size: 27,),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => const Login()),
          );
        },
      ),
      body: Stack(
        // alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            height: 297,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets_images/recovery_background.jpeg'),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 200),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PasswordLostWidgets(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
