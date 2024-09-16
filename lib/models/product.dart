import 'package:flutter/material.dart';

class Prodotto {
  const Prodotto(
    {
    required this.nomeProdotto,
    required this.codice,
    this.prezzo = '', 
  });

  final String nomeProdotto;
  final String codice;
  final String prezzo;
}

class Fornitore {
  const Fornitore({
    required this.nomeFornitore,
    required this.indirizzo,
    required this.categoria,
    required this.prodotto,
  });

  final String nomeFornitore;
  final Indirizzo indirizzo;
  final String categoria;
  final List<Prodotto> prodotto;
}

class Indirizzo {
  const Indirizzo({
    required this.via,
    required this.cap,
    required this.citta,
  });

  final String via;
  final int cap;
  final String citta;
}

class Categoria {
  const Categoria({
    required this.id,
    required this.nomeCategoria,
    required this.colore,
    required this.icona,
  });

  final String id;
  final String nomeCategoria;
  final Color colore;
  final String icona;
}

class Spese {



final Categoria categoria;
  final List<Fornitore> fornitore;
}