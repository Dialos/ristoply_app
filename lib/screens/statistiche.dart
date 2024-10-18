import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:ristoply_app/data/dummy_data.dart';
import 'package:ristoply_app/widgets/statistiche/bar_chart.dart';
// import 'package:ristoply_app/widgets/statistiche/elenco_spese.dart';

class Statistiche extends StatefulWidget {
  const Statistiche({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StatisticheState();
  }
}

class _StatisticheState extends State<Statistiche> {
  final colorCat = {
    '1': const Color.fromRGBO(255, 173, 175, 1),
    '2': const Color.fromRGBO(182, 206, 255, 1),
    '3': const Color.fromRGBO(198, 237, 174, 1),
    '4': const Color.fromRGBO(174, 221, 255, 1),
    '5': const Color.fromRGBO(225, 229, 33, 1),
    '6': const Color.fromRGBO(255, 237, 186, 1),
    '7': const Color.fromRGBO(255, 250, 225, 1),
    '8': const Color.fromRGBO(255, 216, 178, 1),
    '9': const Color.fromRGBO(221, 221, 221, 1)
  };

  int selectedRadioTile = 1;
  final DateTime _selectedDate = DateTime.now();
  String _selectedMonth =
      DateFormat.MMMM('it').format(DateTime.now()).toString().toCapitalized;
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
  int selezionaAnno = DateTime.now().year;

  String selezionaMese =
      DateFormat.MMMM('it').format(DateTime.now()).toString().toCapitalized;
  int? selezionaCat;
  int _ordiniTotAnno = 0;
  int _ordiniTotMese = 0;

  double _spesaTotAnno = 0.0;
  double _spesaTotMese = 0.0;
  Map<int, double> _spesaTotAnnoCat = {};
  Map<int, double> _spesaTotMeseCat = {};

  late Future<List<Map<String, Object>>>? newFutureJsonDataAnnoCat;
  late Future<List<Map<String, Object>>>? newFutureJsonDataMeseCat;

  @override
  void initState() {
    super.initState();
    readJson();
    newFutureJsonDataAnnoCat = newJsonAnnoCat();
    newFutureJsonDataMeseCat = newJsonMeseCat();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/assets_file/json_ristoply_v1.json');
    final data = await jsonDecode(response);
    setState(() {
      _items = data;

      for (var anno in _items['anni']) {
        _anni.add(anno['nomeAnno']);
      }

      for (var anno in _items['anni']) {
        if (anno['nomeAnno'] == selezionaAnno) {
          for (var mese in anno['mesi']) {
            _mesi.add(mese['nomeMese']);
          }
        }
      }

      if (!_anni.contains(selezionaAnno)) {
        _anni.add(selezionaAnno);
        _mesi.insert(0, _selectedMonth);
      } else if (_anni.contains(selezionaAnno)) {
        aggiornaMesi(selezionaAnno);
        if (_mesi.isEmpty || !_mesi.contains(_selectedMonth)) {
          _mesi.insert(0, _selectedMonth);
          selezionaMese = _selectedMonth;
        }
      }

      _calcolaOrdini();
      _calcolaSpesa();
      newFutureJsonDataAnnoCat = newJsonAnnoCat();
      newFutureJsonDataMeseCat = newJsonMeseCat();
    });
  }

  void aggiornaMesi(int selezionaAnno) {
    setState(() {
      _mesi.clear();
      _anni.clear();
      for (var anno in _items['anni']) {
        _anni.add(anno['nomeAnno']);
      }

      for (var anno in _items['anni']) {
        if (anno['nomeAnno'] == selezionaAnno) {
          for (var mese in anno['mesi']) {
            _mesi.add(mese['nomeMese']);
          }
        }
      }
      if (!_mesi.contains(selezionaMese) && _mesi.isNotEmpty) {
        selezionaMese = _mesi.first;
      }
      _calcolaOrdini();
      _calcolaSpesa();
    });
  }

  String _getNomeCat(int selezionaCat) {
    return availableCategories
        .firstWhere((categoria) => categoria.id == selezionaCat)
        .nome;
  }

  void _calcolaOrdini() {
    _ordiniTotAnno = 0;
    _ordiniTotMese = 0;

    for (var anno in _items['anni']) {
      if (anno['nomeAnno'] == selezionaAnno) {
        List<String> fornitoriAnno = [];
        for (var mese in anno['mesi']) {
          for (var categoria in mese['categorie']) {
            for (var fornitore in categoria['fornitori']) {
              fornitoriAnno.add(fornitore['nomeFornitore']);
            }
          }
        }
        _ordiniTotAnno = fornitoriAnno.length;

        for (var mese in anno['mesi']) {
          if (mese['nomeMese'] == selezionaMese) {
            List<String> fornitoriMese = [];
            for (var categoria in mese['categorie']) {
              for (var fornitore in categoria['fornitori']) {
                fornitoriMese.add(fornitore['nomeFornitore']);
              }
            }
            _ordiniTotMese = fornitoriMese.length;
            break;
          }
        }
        break;
      }
    }
  }

  void _calcolaSpesa() {
    _spesaTotAnnoCat.clear();
    _spesaTotMeseCat.clear();

    _spesaTotAnno = 0.0;
    _spesaTotMese = 0.0;

    for (var anno in _items['anni']) {
      if (anno['nomeAnno'] == selezionaAnno) {
        for (var mese in anno['mesi']) {
          for (var categoria in mese['categorie']) {
            int idCategoria = categoria['idCategoria'];
            _spesaTotAnnoCat[idCategoria] ??= 0.0;
            _spesaTotMeseCat[idCategoria] ??= 0.0;
            for (var fornitore in categoria['fornitori']) {
              for (var prodotto in fornitore['prodotti']) {
                double costoProdotto =
                    (prodotto['quantita'] * prodotto['prezzo']).toDouble();
                _spesaTotAnnoCat[idCategoria] =
                    _spesaTotAnnoCat[idCategoria]! + costoProdotto;
                _spesaTotAnno += costoProdotto;
                if (mese['nomeMese'] == selezionaMese) {
                  _spesaTotMeseCat[idCategoria] =
                      _spesaTotAnnoCat[idCategoria]! + costoProdotto;
                  _spesaTotMese += costoProdotto;
                }
              }
            }
          }
        }
        break;
      }
    }
  }

  Future<List<Map<String, Object>>> newJsonMeseCat() async {
    List<Map<String, Object>> newDataMeseCat = [];

    _spesaTotMeseCat.forEach((selezionaCat, spesa) {
      final categoria = _getNomeCat(selezionaCat);
      if (spesa > 0) {
        newDataMeseCat.add({
          'spesa': spesa.toInt(),
          'categoria': categoria,
          'colore': selezionaCat,
        });
      }
    });
    return newDataMeseCat;
  }

  Future<List<Map<String, Object>>> newJsonAnnoCat() async {
    List<Map<String, Object>> newDataAnnoCat = [];

    _spesaTotAnnoCat.forEach((selezionaCat, spesa) {
      final categoria = _getNomeCat(selezionaCat);
      if (spesa > 0) {
        newDataAnnoCat.add({
          'spesa': spesa.toInt(),
          'categoria': categoria,
          'colore': selezionaCat
        });
      }
    });
    return newDataAnnoCat;
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
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text(
                              DateFormat.y('it')
                                  .format(_selectedDate)
                                  .toString(),
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
                            onChanged: (newValue) {
                              setState(
                                () {
                                  aggiornaMesi(selezionaAnno);
                                  selezionaAnno = newValue!;
                                  _calcolaOrdini();
                                  _calcolaSpesa();
                                  newFutureJsonDataAnnoCat = newJsonAnnoCat();
                                  newFutureJsonDataMeseCat = newJsonMeseCat();
                                },
                              );
                            },
                            items: _anni.map<DropdownMenuItem<int>>(
                              (anno) {
                                return DropdownMenuItem<int>(
                                  value: anno,
                                  child: Text(
                                    anno.toString(),
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
                              DateFormat.MMMM('it')
                                  .format(_selectedDate)
                                  .toString()
                                  .toCapitalized,
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
                            onChanged: (newValue) {
                              setState(
                                () {
                                  selezionaMese = newValue!;
                                  _calcolaOrdini();
                                  _calcolaSpesa();
                                  newFutureJsonDataAnnoCat = newJsonAnnoCat();
                                  newFutureJsonDataMeseCat = newJsonMeseCat();
                                },
                              );
                            },
                            items: _mesi.map<DropdownMenuItem<String>>(
                              (mese) {
                                return DropdownMenuItem<String>(
                                  value: mese,
                                  child: Text(
                                    mese,
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
                          DateFormat.y('it').format(_selectedDate).toString(),
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
                        onChanged: (newValue) {
                          setState(
                            () {
                              selezionaAnno = newValue!;
                              _calcolaOrdini();
                              _calcolaSpesa();
                              newFutureJsonDataAnnoCat = newJsonAnnoCat();
                              newFutureJsonDataMeseCat = newJsonMeseCat();
                            },
                          );
                        },
                        items: _anni.map<DropdownMenuItem<int>>(
                          (anno) {
                            return DropdownMenuItem<int>(
                              value: anno,
                              child: Text(
                                anno.toString(),
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
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.only(top: 10),
                  //  width: 350,
                  height: 350,
                  child: selectedRadioTile == 1
                      ? FutureBuilder<List<Map<String, Object>>>(
                          future: newFutureJsonDataMeseCat,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text("Errore nel caricamento dei dati"),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                child: Text("Nessun dato disponibile"),
                              );
                            } else {
                              var newJsonData = snapshot.data!;
                              return Chart(
                                data: newJsonData,
                                variables: {
                                  'categoria': Variable(
                                    accessor: (Map map) =>
                                        map['categoria'] as String,
                                  ),
                                  'spesa': Variable(
                                    accessor: (Map map) => map['spesa'] as int,
                                  ),
                                  'colore': Variable(
                                    accessor: (Map map) => map['colore'] as int,
                                  ),
                                },
                                transforms: [
                                  Proportion(
                                    variable: 'spesa',
                                    as: 'percent',
                                  )
                                ],
                                marks: [
                                  IntervalMark(
                                    position:
                                        Varset('percent') / Varset('categoria'),
                                    label: LabelEncode(
                                      encoder: (tuple) => Label(
                                        tuple['categoria'].toString(),
                                        LabelStyle(
                                          textStyle: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    color: ColorEncode(
                                        variable: 'colore',
                                        values: colorCat.values.toList()),
                                    modifiers: [StackModifier()],
                                  )
                                ],
                                coord:
                                    PolarCoord(transposed: true, dimCount: 1),
                              );
                            }
                          },
                        )
                      : FutureBuilder<List<Map<String, Object>>>(
                          future: newFutureJsonDataAnnoCat,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text("Errore nel caricamento dei dati"),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                child: Text("Nessun dato disponibile"),
                              );
                            } else {
                              var newJsonData = snapshot.data!;
                              return Chart(
                                data: newJsonData,
                                variables: {
                                  'categoria': Variable(
                                    accessor: (Map map) =>
                                        map['categoria'] as String,
                                  ),
                                  'spesa': Variable(
                                    accessor: (Map map) => map['spesa'] as int,
                                  ),
                                  'colore': Variable(
                                    accessor: (Map map) => map['colore'] as int,
                                  ),
                                },
                                transforms: [
                                  Proportion(
                                    variable: 'spesa',
                                    as: 'percent',
                                  )
                                ],
                                marks: [
                                  IntervalMark(
                                    position:
                                        Varset('percent') / Varset('categoria'),
                                    label: LabelEncode(
                                      encoder: (tuple) => Label(
                                        tuple['categoria'].toString(),
                                        LabelStyle(
                                          textStyle: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    color: ColorEncode(
                                        variable: 'colore',
                                        values: colorCat.values.toList()),
                                    modifiers: [StackModifier()],
                                  )
                                ],
                                coord:
                                    PolarCoord(transposed: true, dimCount: 1),
                              );
                            }
                          },
                        ),
                ),

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
                      selectedRadioTile == 1
                          ? Text(
                              '€ ${_spesaTotMese.toStringAsFixed(2)}',
                              style: GoogleFonts.getFont(
                                'DM Sans',
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(1, 0, 13, 1),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          : Text(
                              '€ ${_spesaTotAnno.toStringAsFixed(2)}',
                              style: GoogleFonts.getFont(
                                'DM Sans',
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(1, 0, 13, 1),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                      selectedRadioTile == 1
                          ? Text(
                              '$_ordiniTotMese ordini',
                              style: GoogleFonts.getFont(
                                'DM Sans',
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(83, 90, 115, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          : Text(
                              '$_ordiniTotAnno ordini',
                              style: GoogleFonts.getFont(
                                'DM Sans',
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(83, 90, 115, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
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
              //   Container(
              //     child: ListView.builder(
              //       itemCount: _categorie.length,
              //       itemBuilder: (context, index) {
              //         return ListTile(
              //           title: Text(
              //               'IdCat: ${_getNomeCat(_categorie.elementAt(index))}'),
              //         );
              //       },
              //     ),
              //  )
              ],
            ),

// ElencoSpeseScreen(),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String get toCapitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String get toTitleCase => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized)
      .join(' ');
}
