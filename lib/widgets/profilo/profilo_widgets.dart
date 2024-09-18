import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ristoply_app/widgets/profilo/account.dart';
import 'package:ristoply_app/widgets/profilo/fornitore.dart';
import 'package:ristoply_app/widgets/profilo/impostazioni.dart';
import 'package:ristoply_app/widgets/profilo/ordini.dart';
import 'package:ristoply_app/widgets/profilo/stat.dart';

// INSERIRE SHADOW ATTORNO I CONTAINER

class ProfiloWidgets extends StatelessWidget {
  const ProfiloWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(246, 246, 247, 1),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(50.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets_images/chef.png',
                      width: 74,
                      height: 102.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rossopomodoro',
                            style: GoogleFonts.getFont(
                              'DM Sans',
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            'rossopomodoro@gmail.com',
                            style: GoogleFonts.getFont(
                              'DM Sans',
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(143, 146, 161, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OrdiniWidgets(),
                  //     SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  // Spacer(),
                  Expanded(child: SizedBox()),
                  StatWidgets(),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AccountWidgets(),
                  Spacer(),
                  FornitoreWidgets(),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              const Padding(
                padding: EdgeInsets.only(
                  left: 40,
                  right: 40,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SettingWidgets(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
