import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ristoply_app/screens/bottom_tab.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ristoply_app/screens/login.dart';

class SigninWidgets extends StatefulWidget {
  const SigninWidgets({super.key});

  @override
  State<SigninWidgets> createState() => _SigninWidgetsState();
}

class _SigninWidgetsState extends State<SigninWidgets> {
  bool _pwVisibility = true;
  bool? _isSelected = false;
  final Uri _urlTC = Uri.parse(
      'https://drive.google.com/file/d/1MFpLb7q9PyM_AHs1_yYjbnJtDFTHqlv1/view');
  final Uri _urlPrivacy = Uri.parse(
      'https://drive.google.com/file/d/1sjpgH0RsoppfrSZoUZ0Zxk_1HnVPaSdC/view');

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        //     height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(246, 246, 247, 1),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(50.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Crea un account',
                  style: GoogleFonts.getFont(
                    'DM Sans',
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  'Benvenuto, registrati per continuare',
                  style: GoogleFonts.getFont(
                    'DM Sans',
                    textStyle: const TextStyle(
                      color: Color.fromRGBO(29, 29, 29, 0.5),
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Nome attività',
                  style: GoogleFonts.getFont(
                    'DM Sans',
                    textStyle: const TextStyle(
                      color: Color.fromRGBO(1, 0, 13, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: false,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.person_outlined),
                    filled: true,
                    fillColor: const Color.fromRGBO(143, 146, 161, 0.08),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Es. Mio Ristorante',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(29, 29, 29, 0.5),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Email',
                  style: GoogleFonts.getFont(
                    'DM Sans',
                    textStyle: const TextStyle(
                      color: Color.fromRGBO(1, 0, 13, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.mail_outline),
                    filled: true,
                    fillColor: const Color.fromRGBO(143, 146, 161, 0.08),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Es. mioristorante@gmail.com',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(29, 29, 29, 0.5),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Password',
                  style: GoogleFonts.getFont(
                    'DM Sans',
                    textStyle: const TextStyle(
                      color: Color.fromRGBO(1, 0, 13, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: false,
                  obscureText: _pwVisibility,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: _pwVisibility
                          ? const Icon(Icons.visibility_off_outlined)
                          : const Icon(Icons.visibility_outlined),
                      onPressed: () {
                        setState(() {
                          _pwVisibility = !_pwVisibility;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: const Color.fromRGBO(143, 146, 161, 0.08),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: '* * * * * * * * * * * * * * ',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(29, 29, 29, 0.5),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: const Color.fromRGBO(0, 173, 143, 1),
                        value: _isSelected,
                        onChanged: (value) {
                          setState(() {
                            _isSelected = value;
                          });
                        }),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Creando quest’account acconsenti ai nostri ',
                          style: GoogleFonts.getFont(
                            'DM Sans',
                            textStyle: const TextStyle(
                              color: Color.fromRGBO(29, 29, 29, 0.5),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          children: [
                            TextSpan(
                              text: 'Termini e Condizioni ',
                              style: GoogleFonts.getFont(
                                'DM Sans',
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(1, 0, 13, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  if (!await launchUrl(
                                    _urlTC,
                                    mode: LaunchMode.externalApplication,
                                  )) {
                                    throw Exception(
                                        'C\'è stato un errore, riprova più tardi');
                                  }
                                },
                            ),
                            TextSpan(
                              text: 'e alla ',
                              style: GoogleFonts.getFont(
                                'DM Sans',
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(29, 29, 29, 0.5),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: GoogleFonts.getFont(
                                'DM Sans',
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(1, 0, 13, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  if (!await launchUrl(
                                    _urlPrivacy,
                                    mode: LaunchMode.externalApplication,
                                  )) {
                                    throw Exception(
                                        'C\'è stato un errore, riprova più tardi');
                                  }
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const BottomTab()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      backgroundColor: const Color.fromRGBO(39, 117, 104, 1),
                    ),
                    child: Text(
                      'Registrati',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'DM Sans',
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Hai già un account? ',
                            style: GoogleFonts.getFont(
                              'DM Sans',
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(29, 29, 29, 0.5),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            children: [
                              TextSpan(
                                text: 'Accedi',
                                style: GoogleFonts.getFont(
                                  'DM Sans',
                                  textStyle: const TextStyle(
                                    color: Color.fromRGBO(1, 0, 13, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => const Login()));
                                  },
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
