import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';



class PieDatePicker extends StatefulWidget {
  const PieDatePicker({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PieDatePickerState();
  }
}

class _PieDatePickerState extends State<PieDatePicker> {
  DateTime _selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextButton(
        child: Row(
          children: [
            Text(
              DateFormat.yMMMM('it').format(_selected).toString().toCapitalized,
              style: GoogleFonts.getFont(
                'DM Sans',
                textStyle: const TextStyle(
                  color: Color.fromRGBO(1, 0, 13, 1),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Color.fromRGBO(45, 45, 45, 1),
            ),
          ],
        ),
        onPressed: () async => _onPressed(context: context),
      ),
    );
  }

  Future<void> _onPressed({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: const Locale('it'),
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // quanto voglio andare indietro
      lastDate: DateTime.now(),
      helpText: 'Seleziona una data',
      cancelText: 'Chiudi',
    );

    if (pickedDate != null) {
      setState(() {
        _selected = pickedDate;
      });
    }
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
