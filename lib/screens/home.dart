import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ristoply_app/widgets/home/home_widgets.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(39, 117, 104, 1),
      body: Stack(
        children: [
          Container(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.only(top: 80, left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Benvenuto su ristoply ',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.getFont(
                          'Hanken Grotesk',
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.waving_hand,
                        color: Colors.amber,
                      )
                    ],
                  ),
                  Text(
                    'Scegli la categoria prodotto di cui hai bisogno.',
                    style: GoogleFonts.getFont(
                      'DM Sans',
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 190),
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(246, 246, 247, 1),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50.0),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HomeWidgets(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
