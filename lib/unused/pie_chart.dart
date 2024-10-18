import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:ristoply_app/data/pie_data.dart';

class PieChart extends StatelessWidget {
  const PieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      color: Colors.white,
                    ),
      margin: const EdgeInsets.only(top: 10),
    //  width: 350,
      height: 350,
      child: Chart(
        data: pieData,
        variables: {
          'name': Variable(
            accessor: (Map map) => map['name'] as String,
          ),
          'value': Variable(
            accessor: (Map map) => map['value'] as num,
          ),
          'colore': Variable(
            accessor: (Map map) => map['colore'] as String,
          ),
        },
        transforms: [
          Proportion(
            variable: 'value',
            as: 'percent',
          )
        ],
        marks: [
          IntervalMark(
            position: Varset('percent') / Varset('name'),
            label: LabelEncode(
                encoder: (tuple) => Label(
                      tuple['name'].toString(),
                      LabelStyle(
                          textStyle: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                    )),
            color: ColorEncode(
                variable: 'colore', values: colorType.values.toList()),
            modifiers: [StackModifier()],
          )
        ],
        coord: PolarCoord(transposed: true, dimCount: 1),
      ),
    );
  }
}
