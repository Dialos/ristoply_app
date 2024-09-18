import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DatePickerState();
  }
}

class _DatePickerState extends State<DatePicker> {
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
              DateFormat().add_yMMMM().format(_selected),
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
            const Icon(Icons.keyboard_arrow_down_outlined),
          ],
        ),
        onPressed: () async => _onPressed(context: context),
      ),
    );
  }

  Future<void> _onPressed({required BuildContext context}) async {
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selected,
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // This will change to light theme.
          child: child!,
        );
      },
    );

    if (selected != null) {
      setState(() {
        _selected = selected;
      });
    }
  }
}
