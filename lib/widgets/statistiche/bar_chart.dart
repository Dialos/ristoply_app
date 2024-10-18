import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ristoply_app/data/dummy_data.dart';

class BarChart extends StatefulWidget {
  const BarChart({super.key});

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  final DateTime _selectedDate = DateTime.now();

  late Future<List<Map<String, Object>>>? newFutureJsonData;
  Map<String, dynamic> _items = {};
  List<int> _categorie = [];
  List _anni = [];
  List _am = [];
  List _mesi = [];
  int selezionaAnno = DateTime.now().year;
  String? selezionaMese;
  int? selezionaCat;

  @override
  void initState() {
    super.initState();
    readJson();
    newFutureJsonData = newJson();
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

      aggiornaCategorie(selezionaAnno);
      _am = _items['anni'];

      newFutureJsonData = newJson();
    });
  }

  void aggiornaCategorie(int selezionaAnno) {
    setState(() {
      _categorie.clear();
      _categorie.add(0);
      Set<int> _catSet = {};
      for (var anno in _items['anni']) {
        if (anno['nomeAnno'] == selezionaAnno) {
          for (var mese in anno['mesi']) {
            for (var categoria in mese['categorie']) {
              _catSet.add(categoria['idCategoria']);
            }
          }
        }
      }
      _categorie.addAll(_catSet);
    });
  }

  List<DataRow> _createRows() {
    List<DataRow> row = [];

    for (var anno in _items['anni'] ?? []) {
      if (anno['nomeAnno'] == selezionaAnno) {
        for (var mese in anno['mesi']) {
          double spesaMeseTotale = 0;
          for (var categoria in mese['categorie']) {
            if (selezionaCat == 0 ||
                selezionaCat == null ||
                categoria['idCategoria'] == selezionaCat) {
              for (var fornitore in categoria['fornitori']) {
                for (var prodotto in fornitore['prodotti']) {
                  spesaMeseTotale += prodotto['quantita'] * prodotto['prezzo'];
                }
              }
            }
          }
          if (spesaMeseTotale > 0) {
            row.add(
              DataRow(cells: [
                DataCell(
                  Text(
                    mese['nomeMese'],
                    style: GoogleFonts.getFont(
                      'DM Sans',
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    '€${spesaMeseTotale.toStringAsFixed(2)}',
                    style: GoogleFonts.getFont(
                      'DM Sans',
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ]),
            );
          }
        }
      }
    }
    return row;
  }

  String _getNomeCat(int selezionaCat) {
    return availableCategories
        .firstWhere((categoria) => categoria.id == selezionaCat)
        .nome;
  }

  Future<List<Map<String, Object>>> newJson() async {
    List<Map<String, Object>> newData = [];

    for (var anno in _items['anni'] ?? []) {
      if (anno['nomeAnno'] == selezionaAnno) {
        for (var mese in anno['mesi']) {
          double spesaMeseTotale = 0;
          for (var categoria in mese['categorie']) {
            if (selezionaCat == 0 ||
                selezionaCat == null ||
                categoria['idCategoria'] == selezionaCat) {
              for (var fornitore in categoria['fornitori']) {
                for (var prodotto in fornitore['prodotti']) {
                  spesaMeseTotale += prodotto['quantita'] * prodotto['prezzo'];
                }
              }
            }
          }
          if (spesaMeseTotale > 0) {
            newData.add({
              'mese': mese['nomeMese'],
              'spesa': spesaMeseTotale.toPrecision(1)
            });
          }
        }
      }
    }
    return newData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
// Dropdown anno
          DropdownButton<int>(
            value: selezionaAnno,
            hint: Text(
              DateFormat.y('it').format(_selectedDate).toString(),
              style: GoogleFonts.getFont(
                'DM Sans',
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onChanged: (newValue) {
              setState(
                () {
                  selezionaAnno = newValue!;
                  selezionaCat = null;
                  _mesi = _am.firstWhere(
                      (anno) => anno['nomeAnno'] == newValue)['mesi'];
                  newFutureJsonData = newJson();
                },
              );
              aggiornaCategorie(newValue!);
            },
            items: _anni.map(
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
        ],
      ),

// Dropdown Caregorie
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'Report annuale',
                style: GoogleFonts.getFont(
                  'DM Sans',
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: DropdownButton<int>(
                value: selezionaCat,
                hint: Text(
                  "Spesa totale",
                  style: GoogleFonts.getFont(
                    'DM Sans',
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                items: _categorie.map((categoria) {
                  return DropdownMenuItem<int>(
                    value: categoria,
                    child: Text(
                      _getNomeCat(categoria),
                      style: GoogleFonts.getFont(
                        'DM Sans',
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(
                    () {
                      selezionaCat = newValue!;
                      newFutureJsonData = newJson();
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),

// Bar Chart
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.width * 0.7,
              child: FutureBuilder<List<Map<String, Object>>>(
                future: newFutureJsonData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Errore nel caricamento dei dati"),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text("Nessun dato disponibile"),
                    );
                  } else {
                    var newJsonData = snapshot.data!;
                    return Chart(
                      data: newJsonData,
                      variables: {
                        'mese': Variable(
                          accessor: (Map map) => map['mese'] as String,
                        ),
                        'spesa': Variable(
                          accessor: (Map map) => map['spesa'] as num,
                        ),
                      },
                      marks: [
                        IntervalMark(
                          // label: LabelEncode(
                          //     encoder: (tuple) => Label(tuple['spesa'].toString())),
                          elevation: ElevationEncode(value: 0, updaters: {
                            'tap': {true: (_) => 5}
                          }),
                          gradient: GradientEncode(
                              value: const LinearGradient(
                                colors: [
                                  Color.fromRGBO(170, 245, 233, 0.675),
                                  Color.fromRGBO(0, 173, 143, 1)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                              updaters: {
                                'tap': {
                                  true: (color) => const LinearGradient(
                                        colors: [
                                          Color.fromRGBO(39, 117, 104, 1),
                                          Color.fromRGBO(6, 67, 57, 0.675),
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      )
                                }
                              }),
                        )
                      ],
                      axes: [
                        Defaults.horizontalAxis,
                        // Defaults.verticalAxis,
                        AxisGuide(
                          label: LabelStyle(
                            textStyle: const TextStyle(
                              fontSize: 10,
                              color: Color(0xff808080),
                            ),
                            offset: const Offset(-0.75, 0),
                          ),
                          grid: PaintStyle(
                            strokeColor: const Color(0xffe8e8e8),
                            strokeWidth: 1,
                          ),
                        )
                      ],
                      selections: {'tap': PointSelection(dim: Dim.x)},
                      tooltip: TooltipGuide(),
                      crosshair: CrosshairGuide(),
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),

//  BarDataTable(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.resolveWith(
                        (states) => const Color.fromRGBO(246, 246, 247, 1)),
                    border: TableBorder.all(
                      width: 3.0,
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(246, 246, 247, 1),
                    ),
                    columns: [
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            textAlign: TextAlign.center,
                            'Mesi',
                            style: GoogleFonts.getFont(
                              'DM Sans',
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(1, 0, 13, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            textAlign: TextAlign.center,
                            'Importi',
                            style: GoogleFonts.getFont(
                              'DM Sans',
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(1, 0, 13, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: _createRows(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

extension NumberRounding on num {
  num toPrecision(int precision) {
    return num.parse((this).toStringAsFixed(precision));
  }
}
