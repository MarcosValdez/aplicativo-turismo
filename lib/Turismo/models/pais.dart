import 'package:equatable/equatable.dart';

class Pais extends Equatable {
  const Pais({required this.codigo, required this.continente, required this.nombre});

  final String codigo;
  final String continente;
  final String nombre;

  @override
  List<Object> get props => [codigo, continente, nombre];
}