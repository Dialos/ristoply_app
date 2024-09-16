import 'package:flutter/material.dart';

import 'package:ristoply_app/models/product.dart';

const availableCategories = [
  Categoria(
    id: '1',
    nomeCategoria: 'Carne',
    colore: Color.fromRGBO(255, 173, 175, 1),
    icona: '🥩',
  ),
  Categoria(
    id: '2',
    nomeCategoria: 'No Food',
    colore: Color.fromRGBO(221, 221, 221, 1),
    icona: '🥣',
  ),
  Categoria(
    id: '3',
    nomeCategoria: 'Ittico',
    colore: Color.fromRGBO(182, 206, 255, 1),
    icona: '🍤',
  ),
  Categoria(
    id: '4',
    nomeCategoria: 'Ortofrutta',
    colore: Color.fromRGBO(198, 237, 174, 1),
    icona: '🥬',
  ),
  Categoria(
    id: '5',
    nomeCategoria: 'Beverage',
    colore: Color.fromRGBO(174, 221, 255, 1),
    icona: '🍷',
  ),
  Categoria(
    id: '6',
    nomeCategoria: 'Olio',
    colore: Color.fromRGBO(225, 229, 33, 1),
    icona: '🍾',
  ),
  Categoria(
    id: '7',
    nomeCategoria: 'Alimenti vari',
    colore: Color.fromRGBO(255, 237, 186, 1),
    icona: '🍱',
  ),
  Categoria(
    id: '8',
    nomeCategoria: 'Caseario',
    colore: Color.fromRGBO(255, 250, 225, 1),
    icona: '🧀',
  ),
  Categoria(
    id: '9',
    nomeCategoria: 'Cash & Carry',
    colore: Color.fromRGBO(255, 216, 178, 1),
    icona: '💰',
  ),
];

const dummyStore = [
  Fornitore(
      nomeFornitore: 'Macelleria Bifulco',
      indirizzo: Indirizzo(
          via: 'Via Raffaele Pappalardo', cap: 80044, citta: 'Ottaviano (NA)'),
      categoria: '1',
      prodotto: [Prodotto(nomeProdotto: 'Salsicce', codice: '01886'),
      Prodotto(nomeProdotto: 'Costatelle', codice: '01834'),
      Prodotto(nomeProdotto: 'Salame napoletano', codice: '01823'),
      Prodotto(nomeProdotto: 'Prosciutto cotto', codice: '01844'),
      Prodotto(nomeProdotto: 'Arrosto di manzo', codice: '01855'),
      Prodotto(nomeProdotto: 'Petto di pollo', codice: '01822'),
      Prodotto(nomeProdotto: 'Salame milanese', codice: '01823'),
      Prodotto(nomeProdotto: 'Prosciutto crudo', codice: '01844'),
      Prodotto(nomeProdotto: 'PEtto di tacchino', codice: '01855'),
      Prodotto(nomeProdotto: 'Hamburger', codice: '01866'),])
];
