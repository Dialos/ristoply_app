import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordLostWidgets extends StatefulWidget {
  const PasswordLostWidgets({super.key});

  @override
  State<PasswordLostWidgets> createState() => _PasswordLostWidgetsState();
}

class _PasswordLostWidgetsState extends State<PasswordLostWidgets> {
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
                  'Hai dimenticato la password?',
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
                  'Inserisci la tua e-mail per ricevere il link per impostare una nuova password',
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
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      backgroundColor: const Color.fromRGBO(39, 117, 104, 1),
                    ),
                    child: Text(
                      'Invia email',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
