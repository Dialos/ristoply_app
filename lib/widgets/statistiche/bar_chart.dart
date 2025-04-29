import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:ristoply_app/data/bar_data.dart';
import 'package:google_fonts/google_fonts.dart';

class BarChart extends StatefulWidget {
  const BarChart({super.key});

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  DateTime? _selectedDate = DateTime(DateTime.now().year, DateTime.now().month);
  var dropMenuDate = DateTime.now().year.toString();

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _presentDatePicker,
            icon: DropdownButton(
              value: dropMenuDate,
              icon: const Icon(Icons.keyboard_arrow_down_outlined),
              items: barData.map((element) {
                return DropdownMenuItem(
                  value: element,
                  child: Text(element.toString()),
                );
              }).toList(),
              onChanged: <String>(newValue) {
                setState(() {
                  dropMenuDate = newValue;
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
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.width * 0.7,
              child: Chart(
                data: barData,
                variables: {
                  'Mese': Variable(
                    accessor: (Map map) => map['Mese'] as String,
                  ),
                  'Importo': Variable(
                    accessor: (Map map) => map['Importo'] as num,
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
          ],
        ),
      ),
    );
  }
}
