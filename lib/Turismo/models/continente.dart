import 'package:equatable/equatable.dart';

class Continente extends Equatable {
  const Continente({required this.codigo, required this.nombre});

  final String codigo;
  final String nombre;

  @override
  List<Object> get props => [codigo, nombre];
}