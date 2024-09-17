

import 'package:flutter/material.dart';
import 'package:ristoply_app/data/dummy_data.dart';
import 'package:ristoply_app/widgets/statistiche/spese/spese_dettaglio.dart';
import 'package:ristoply_app/widgets/statistiche/spese/spese_list_item.dart';

class ElencoSpeseScreen extends StatefulWidget {
  const ElencoSpeseScreen(
      {super.key,
      required this.elencoSpese});

  final List<Spese> elencoSpese;

  @override
  State<ElencoSpeseScreen> createState() => _ElencoSpeseScreenState();
}

class _ElencoSpeseScreenState extends State<ElencoSpeseScreen>{



  void __spesaSelezionata(BuildContext context, Category category) {
    final filteredMeals = widget.elencoSpese
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => DettaglioSpeseScreen(
              meals: filteredMeals,
              title: category.nomeCategoria,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.all(24),
        children: [
          for (final category in availableCategories)
            SpeseListItem(
              category: category,
              onSelectedCategory: () {
                __spesaSelezionata(context, category);
              },
            )
        ],
    );
  }
}


