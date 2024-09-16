import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ristoply_app/widgets/profilo/profilo_widgets.dart';

class Profilo extends StatelessWidget {
  const Profilo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(39, 117, 104, 1),
      body: Stack(
        children: [
          Container(
          padding: const EdgeInsets.only(top: 70),
          //    alignment: Alignment.bottomCenter,
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      'Profilo',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont(
                        'Hanken Grotesk',
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(255, 183, 46, 1),
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 45),
                    child: Text(
                      'Qui troverai tutti i dettagli del tuo account',
                      style: GoogleFonts.getFont(
                        'DM Sans',
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const ProfiloWidgets(),
                ],
              ),
            ),
      ],),
        );
  }
}
