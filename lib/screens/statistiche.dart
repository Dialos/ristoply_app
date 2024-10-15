import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:ristoply_app/data/dummy_data.dart';
// import 'package:ristoply_app/data/dummy_data.dart';
import 'package:ristoply_app/widgets/statistiche/bar_chart.dart';
// import 'package:ristoply_app/widgets/statistiche/elenco_spese.dart';
import 'package:ristoply_app/widgets/statistiche/pie_chart.dart';

class Statistiche extends StatefulWidget {
  const Statistiche({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StatisticheState();
  }
}

class _StatisticheState extends State<Statistiche> {
  int selectedRadioTile = 1;

  setSelectedRadioTile(int value) {
    setState(() {
      selectedRadioTile = value;
    });
  }

  Future<void> show(BuildContext context) async {
    final result = await showModalBottomSheet(
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

  Map<String, dynamic> _items = {};
  List _anni = [];
  List _mesi = [];
  Set<int> _categorie = {};
  int? selezionaAnno;
  String? selezionaMese;
  int? selezionaCat;

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/assets_file/json_ristoply_v1.json');
    final data = await jsonDecode(response);
    setState(() {
      _items = data;
      _anni = _items['anni'];
    });
  }

  void aggiornaCategorie(int selezionaAnno) {
    setState(() {
      _categorie.clear();
      for (var anno in _items['anni']) {
        if (anno['nomeAnno'] == selezionaAnno) {
          for (var mese in anno['mesi']) {
            for (var categoria in mese['categorie']) {
              _categorie.add(categoria['idCategoria']);
            }
          }
        }
      }
    });
  }

  String _getNomeCat(int selezionaCat) {
    return availableCategories
        .firstWhere((categoria) => categoria.id == selezionaCat)
        .nome;
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
              onPressed: () {
                show(context);
              },
              icon: const Icon(Icons.calendar_month_outlined)),
        ],
      ),
      body: Container(
        color: const Color.fromRGBO(246, 246, 247, 1),
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
// Date picker
              const SizedBox(height: 15),
              selectedRadioTile == 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child:
                              //Anno
                              Padding(
                            padding: const EdgeInsets.only(left: 12, right: 2),
                            child: DropdownButton<int>(
                              isExpanded: true,
                              hint: Text(
                                'Anno',
                                style: GoogleFonts.getFont(
                                  'DM Sans',
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              value: selezionaAnno,
                              onChanged: (int? value) {
                                setState(
                                  () {
                                    selezionaAnno = value;
                                    selezionaMese = null;
                                    _mesi = _anni.firstWhere((anno) =>
                                        anno['nomeAnno'] == value)['mesi'];
                                  },
                                );
                              },
                              items: _anni.map<DropdownMenuItem<int>>(
                                (anno) {
                                  return DropdownMenuItem<int>(
                                    value: anno['nomeAnno'],
                                    child: Text(
                                      anno['nomeAnno'].toString(),
                                      style: GoogleFonts.getFont(
                                        'DM Sans',
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Container(
                          width: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 2),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text(
                                'Mese',
                                style: GoogleFonts.getFont(
                                  'DM Sans',
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              value: selezionaMese,
                              onChanged: (String? value) {
                                setState(
                                  () {
                                    selezionaMese = value;
                                  },
                                );
                              },
                              items: _mesi.map<DropdownMenuItem<String>>(
                                (mese) {
                                  return DropdownMenuItem<String>(
                                    value: mese['nomeMese'],
                                    child: Text(
                                      mese['nomeMese'],
                                      style: GoogleFonts.getFont(
                                        'DM Sans',
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child:
                          //Anno
                          Padding(
                        padding: const EdgeInsets.only(left: 12, right: 2),
                        child: DropdownButton<int>(
                          isExpanded: true,
                          hint: Text(
                            'Anno',
                            style: GoogleFonts.getFont(
                              'DM Sans',
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          value: selezionaAnno,
                          onChanged: (int? value) {
                            setState(
                              () {
                                selezionaAnno = value;
                              },
                            );
                          },
                          items: _anni.map<DropdownMenuItem<int>>(
                            (anno) {
                              return DropdownMenuItem<int>(
                                value: anno['nomeAnno'],
                                child: Text(
                                  anno['nomeAnno'].toString(),
                                  style: GoogleFonts.getFont(
                                    'DM Sans',
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),

// Pie chart
              const SizedBox(height: 7),
              Column(
                children: [
                  const PieChart(),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10)),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      children: [
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
                      ],
                    ),
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
                  // Column(
                  //   children: [
                  //     Flexible(
                  //       fit: FlexFit.loose,
                  //       child: ListView.builder(
                  //           shrinkWrap: true,
                  //           physics: NeverScrollableScrollPhysics(),
                  //           itemCount: _categorie.length,
                  //           itemBuilder: (context, index) {
                  //             return ListTile(
                  //               title: Text(
                  //                   'IdCat: ${_getNomeCat(_categorie.elementAt(index))}'),
                  //             );
                  //           },
                  //         ),
                  //       ),

                  //   ],
                  // ),

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
