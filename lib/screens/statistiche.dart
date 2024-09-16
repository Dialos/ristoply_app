import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ristoply_app/widgets/statistiche/date_picker.dart';
import 'package:ristoply_app/widgets/statistiche/pie_chart.dart';

class Statistiche extends StatefulWidget {
  const Statistiche({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StatisticheState();
  }
}

class _StatisticheState extends State<Statistiche> {
  DateTime currentDate = DateTime.now();

  void show() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(top: 30, left: 24, right: 24),
          height: 272, // Set your desired height
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mostra statistiche per",
                  style: GoogleFonts.getFont(
                    'DM Sans',
                    textStyle: const TextStyle(
                      color: Color.fromRGBO(1, 0, 13, 1),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                TextButton(
                  child: Row(
                    children: [
                      Text(
                        "Mese",
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
                  onPressed: () {},
                ),
                TextButton(
                  child: Row(
                    children: [
                      Text(
                        "Anno",
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
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          'Statistiche',
          style: GoogleFonts.getFont(
            'DM Sans',
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.bar_chart_outlined)),
          IconButton(
              onPressed: show, icon: const Icon(Icons.calendar_month_outlined)),
        ],
      ),
      body: Expanded(
        child: Container(
          color: const Color.fromRGBO(246, 246, 247, 1),
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
// Date picker
                const SizedBox(height: 10),
                DatePicker(),

// Pie chart
                const SizedBox(height: 10),
                Container(
                  child: PieChart(),
                ),

// Testo
                const SizedBox(height: 20),
                Container(
                  color: const Color.fromRGBO(246, 246, 247, 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dettagli spese',
                        style: GoogleFonts.getFont(
                          'DM Sans',
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(11, 20, 52, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        'Le percentuali in evidenza sono da considerarsi rispetto al mese precedente.',
                        style: GoogleFonts.getFont(
                          'DM Sans',
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(1, 0, 13, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

// Elenco spese
                const SizedBox(height: 10),
                Container(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
