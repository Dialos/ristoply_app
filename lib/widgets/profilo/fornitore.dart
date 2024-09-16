import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FornitoreWidgets extends StatelessWidget {
  const FornitoreWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {} ,
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
                color: const Color.fromRGBO(236, 240, 247, 1),
              ),
              child: const Icon(Icons.man_2_outlined),
            ),
            Text(
              'Richiedi fornitore',
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
