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
    return Container(
      child: DataTable( 
        dataRowColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              // Even rows will have a grey color.
              if (index.isEven) {
                return Colors.grey.withOpacity(0.3);
              }
              return null; // Use default value for other states and odd rows.
            }),     
        border: TableBorder.all(color: const Color.fromRGBO(246, 246, 247, 1), borderRadius: BorderRadius.circular(10)),
        columns: <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
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
        rows: const <DataRow>[
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
    );
  }
}
