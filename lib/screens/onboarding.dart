import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ristoply_app/screens/signin.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int _currentPage = 0;
  final _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: isActive ? 12.0 : 8.0,
      width: isActive ? 12.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive
            ? const Color.fromRGBO(39, 117, 104, 1)
            : const Color.fromRGBO(39, 117, 104, 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _currentPage != _numPages - 1
              ? TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => const Signin()));
                  },
                  child: Text(
                    'Skip',
                    style: GoogleFonts.getFont(
                      'DM Sans',
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(39, 117, 104, 1),
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 60),
            height: 500.0,
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'assets_images/onboarding1.png',
                          width: MediaQuery.of(context).size.width * 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Ordina dai tuoi fornitori in un click',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'DM Sans',
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(1, 0, 13, 1),
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Accedi facilmente a tutti i tuoi fornitori e a tantissimi altri, sfoglia i listini e invia il tuo ordine!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'DM Sans',
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(1, 0, 13, 1),
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'assets_images/onboarding2.png',
                          width: MediaQuery.of(context).size.width * 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Gestisci i tuoi ordini',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'DM Sans',
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(1, 0, 13, 1),
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Controlla tutti gli ordini inviati da te e dalla tua brigata. Resta aggiornato sulla data di consegna e la merce in arrivo.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'DM Sans',
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(1, 0, 13, 1),
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'assets_images/onboarding3.png',
                          width: MediaQuery.of(context).size.width * 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Monitora le spese del tuo ristorante',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'DM Sans',
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(1, 0, 13, 1),
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Tieni d’occhio le tue spese e prendi le tue decisioni di business con maggiore consapevolezza.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'DM Sans',
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(1, 0, 13, 1),
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
          const SizedBox(height: 50),
          _currentPage == _numPages - 1
              ? Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 191,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => const Signin()));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            backgroundColor:
                                const Color.fromRGBO(39, 117, 104, 1),
                          ),
                          child: Text(
                            'Inizia',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.getFont(
                              'DM Sans',
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(
                  height: 50,
                ),
        ],
      ),
    );
  }
}
