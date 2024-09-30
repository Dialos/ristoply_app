import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:ristoply_app/data/bar_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ristoply_app/widgets/statistiche/tabella_bar_chart.dart';

class BarChart extends StatefulWidget {
  const BarChart({super.key});

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  DateTime _selectedDate = DateTime(DateTime.now().year);
  late String? dateToString;

  int currentYear = DateTime.now().year;

  List<String> getYears(int year) {
    List<String> dropYearList = [];
    while (year <= currentYear) {
      dropYearList.add(year.toString());
      year++;
    }
    return dropYearList.reversed.toList();
  }

  String? dropdownvalue;
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async => _onPressed(context: context),
            icon: DropdownButton(
              value: null,
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
              icon: const Icon(Icons.keyboard_arrow_down_outlined),
              items: getYears(2020).map((element) {
                return DropdownMenuItem(
                  value: element,
                  child: Text(element),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  dateToString = newValue;
                });
              },
            ),
          ),
        ],
      ),
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
              child: DropdownButton(
                value: null,
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
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
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
                      dropdownvalue = newValue;
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.width * 0.7,
              child: Chart(
                data: barData,
                variables: {
                  'month': Variable(
                    accessor: (Map map) => map['month'] as String,
                  ),
                  'sold': Variable(
                    accessor: (Map map) => map['sold'] as num,
                  ),
                },
                marks: [
                  IntervalMark(
                    // label: LabelEncode(
                    //     encoder: (tuple) => Label(tuple['sold'].toString())),
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
                  //   Defaults.verticalAxis,
                  AxisGuide(
                    label: LabelStyle(
                      textStyle: const TextStyle(
                        fontSize: 10,
                        color: Color(0xff808080),
                      ),
                      offset: const Offset(-7.5, 0),
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
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width * 1,
              child: BarDataTable()),
          ],
        ),
      ),
    );
  }

  Future<void> _onPressed({required BuildContext context}) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      //     locale: const Locale('it'),
      initialDate: now,
      firstDate: DateTime(2000), // quanto voglio andare indietro
      lastDate: firstDate,
      // helpText: 'Seleziona una data',
      // cancelText: 'Chiudi',
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        dateToString = _selectedDate.toString();
      });
    }
  }
}
