import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ristoply_app/screens/bottom_tab.dart';
import 'package:ristoply_app/screens/signin.dart';
import 'package:ristoply_app/screens/recovery.dart';

class LoginWidgets extends StatefulWidget {
  const LoginWidgets({super.key});

  @override
  State<LoginWidgets> createState() => _LoginWidgetsState();
}

class _LoginWidgetsState extends State<LoginWidgets> {
  bool _pwVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
       height: MediaQuery.of(context).size.height,
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
                  'Accedi',
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
                  'Bentornato, accedi per continuare',
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
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Hai dimenticato la ',
                    style: GoogleFonts.getFont(
                      'DM Sans',
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(29, 29, 29, 1),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    children: [
                      TextSpan(
                          text: 'password',
                          style: GoogleFonts.getFont(
                            'DM Sans',
                            textStyle: const TextStyle(
                                color: Color.fromRGBO(29, 29, 29, 1),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => const PasswordLost()));
                            }),
                      TextSpan(
                        text: '?',
                        style: GoogleFonts.getFont(
                          'DM Sans',
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(29, 29, 29, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                      'Accedi',
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
                const SizedBox(height: 30),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center, children: [
                      RichText(
                        text: TextSpan(
                          text: 'Non hai un account? ',
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
                              text: 'Registrati',
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
                                          builder: (ctx) => const Signin()));
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
