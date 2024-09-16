import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ristoply_app/screens/statistiche.dart';

class StatWidgets extends StatelessWidget {
  const StatWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Statistiche()),);
      } ,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: 157,
        height: 157,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(3, 183, 24, 0.06),
              ),
              child: const Icon(Icons.bar_chart_outlined),
            ),
            Text(
              'Statistiche',
              style: GoogleFonts.getFont(
                'DM Sans',
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
