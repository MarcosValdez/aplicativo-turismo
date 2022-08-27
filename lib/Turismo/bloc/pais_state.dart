part of 'pais_bloc.dart';

enum PaisStatus { initial, success, failure }

class PaisState extends Equatable {
  const PaisState({
    this.status = PaisStatus.initial,
    this.paises = const <Pais>[],
    this.codigo = "2",
    this.hasReachedMax = false,
  });

  final PaisStatus status;
  final List<Pais> paises;
  final String? codigo;
  final bool hasReachedMax;

  PaisState copyWith({
    PaisStatus? status,
    List<Pais>? posts,
    String? codigo,
    bool? hasReachedMax,
  }) {
    return PaisState(
      status: status ?? this.status,
      paises: posts ?? this.paises,
      codigo: codigo ?? this.codigo,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${paises.length} }''';
  }

  @override
  List<Object?> get props => [status, paises, codigo, hasReachedMax];
}

class PaisSetState extends PaisState {
  List<Pais> paises;
  final String? codigo;
  
  PaisSetState(this.codigo, this.paises):super(codigo: codigo, paises: paises, status: PaisStatus.success);
  @override
  String toString() {
    return '''PaisSetState { status: $status, hasReachedMax: $hasReachedMax, posts: ${paises.length} }''';
  }

}