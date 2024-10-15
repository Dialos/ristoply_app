import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BarDataTable extends StatefulWidget {
  const BarDataTable({super.key});

  @override
  State<BarDataTable> createState() => _BarDataTableState();
}

class _BarDataTableState extends State<BarDataTable> {
  static const int numItems = 12;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 24, right: 24),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: DataTable(
                headingRowColor: WidgetStateProperty.resolveWith((states) =>  const Color.fromRGBO(246, 246, 247, 1)),
                dataRowColor: WidgetStateProperty.resolveWith((states) => numItems % 2 == 0 ? Colors.white :  const Color.fromRGBO(246, 246, 247, 1)),
                border: TableBorder.all(
                  width: 3.0,
                  borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(246, 246, 247, 1),),
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
                rows: [
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Gennaio')),
                      DataCell(Text('€€€€€€')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Febbraio')),
                      DataCell(Text('€€€€€€')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Marzo')),
                      DataCell(Text('€€€€€€')),
                    ],
                  ),
                ],
          ),
        ),
      ],
    );
  }
}
