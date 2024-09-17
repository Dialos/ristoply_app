import 'package:flutter/material.dart';

const pieData = [
  {'value': 3346, 'name': 'Carne', 'colore': 't1',},
  {'value': 1457, 'name': 'Ittico', 'colore': 't2',},
  {'value': 2563, 'name': 'Ortofrutta', 'colore': 't3',},
  {'value': 3346, 'name': 'Beverage', 'colore': 't4',},
  {'value': 1457, 'name': 'Olio', 'colore': 't5',},
  {'value': 2563, 'name': 'Alimenti vari', 'colore': 't6',},
  {'value': 3346, 'name': 'Caseario', 'colore': 't7',},
  {'value': 1457, 'name': 'Cash & Carry', 'colore': 't8',},
  {'value': 2563, 'name': 'No food', 'colore': 't9',}
];


final colorType = {
      't1': const Color.fromRGBO(255, 173, 175, 1),
      't2': const Color.fromRGBO(182, 206, 255, 1),
      't3': const Color.fromRGBO(198, 237, 174, 1),
      't4': const Color.fromRGBO(174, 221, 255, 1),
      't5': const Color.fromRGBO(225, 229, 33, 1),
      't6': const Color.fromRGBO(255, 237, 186, 1),
      't7': const Color.fromRGBO(255, 250, 225, 1),
      't8': const Color.fromRGBO(255, 216, 178, 1),
      't9': const Color.fromRGBO(221, 221, 221, 1)
    };