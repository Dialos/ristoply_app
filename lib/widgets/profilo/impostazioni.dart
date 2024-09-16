import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingWidgets extends StatelessWidget {
  const SettingWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.only(top: 7, left: 10, bottom: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
       //   width: MediaQuery.of(context).size.width * 0.8,
          height: 79,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 12),
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(163, 163, 164, 0.1),
                ),
                child: const Icon(Icons.settings),
              ),
              Text(
                'Impostazioni',
                style: GoogleFonts.getFont(
                  'DM Sans',
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
