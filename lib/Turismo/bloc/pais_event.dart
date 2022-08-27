part of 'pais_bloc.dart';

abstract class PaisEvent extends Equatable {
  const PaisEvent();

  @override
  List<Object> get props => [];
}

class PostFetched extends PaisEvent {
}

class PaisesFiltro extends PaisEvent {
  final String? codigo;
  final List<Pais> paises;

  const PaisesFiltro(this.codigo,this.paises);
}
