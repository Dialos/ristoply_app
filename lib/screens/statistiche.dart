import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ristoply_app/data/dummy_data.dart';
import 'package:ristoply_app/widgets/statistiche/bar_chart.dart';
// import 'package:ristoply_app/widgets/statistiche/elenco_spese.dart';
import 'package:ristoply_app/widgets/statistiche/pie_chart.dart';
import 'package:ristoply_app/widgets/statistiche/pie_date_picker.dart';

class Statistiche extends StatefulWidget {
  const Statistiche({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StatisticheState();
  }
}

class _StatisticheState extends State<Statistiche> {
  DateTime currentDate = DateTime.now();

  int selectedRadioTile = 1;

  setSelectedRadioTile(int value) {
    setState(() {
      selectedRadioTile = value;
    });
  }

  void show() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                const SizedBox(
                  height: 20,
                ),
                ListView(
                  shrinkWrap: true,
                  children: [
                    RadioListTile(
                      title: Text(
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
                      activeColor: const Color.fromRGBO(39, 117, 104, 1),
                      value: 1,
                      groupValue: selectedRadioTile,
                      onChanged: (value) {
                        setSelectedRadioTile(value!);
                        Navigator.of(context).pop();
                      },
                    ),
                    RadioListTile(
                      title: Text(
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
                      activeColor: const Color.fromRGBO(39, 117, 104, 1),
                      value: 2,
                      groupValue: selectedRadioTile,
                      onChanged: (value) {
                        setSelectedRadioTile(value!);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => const BarChart()),
                );
              },
              icon: const Icon(Icons.bar_chart_outlined)),
          IconButton(
              onPressed: show, icon: const Icon(Icons.calendar_month_outlined)),
        ],
      ),
      body: Container(
        color: const Color.fromRGBO(246, 246, 247, 1),
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
// Date picker
              const SizedBox(height: 10),
              const PieDatePicker(),

// Pie chart
              const SizedBox(height: 10),
              Column(
                children: [
                  const PieChart(),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                      color: Colors.white,
                    ),
                    width: 350,
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(children: [
                      Text(
                        'Spesa totale',
                        style: GoogleFonts.getFont(
                          'DM Sans',
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(83, 90, 115, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        '€ 3563,95',
                        style: GoogleFonts.getFont(
                          'DM Sans',
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(1, 0, 13, 1),
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        '58 ordini',
                        style: GoogleFonts.getFont(
                          'DM Sans',
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(83, 90, 115, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ]),
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
                  //      Container(),

// ElencoSpeseScreen(),

                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
