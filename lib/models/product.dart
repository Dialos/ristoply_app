import 'dart:ui';

class Cat {
  const Cat({
    required this.id,
    required this.nome,
    this.colore,
    this.icona,
  });

  final int id;
  final String nome;
  final Color? colore;
  final String? icona;
}
