import 'dart:async';
import 'dart:convert';

import 'package:aplicativo_turismo/Turismo/models/pais.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'pais_event.dart';
part 'pais_state.dart';

const _postLimit = 5;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PaisBloc extends Bloc<PaisEvent, PaisState> {
  PaisBloc({required this.httpClient}) : super(const PaisState()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    /* on<PaisesFiltro>((event, emit)async {
      print("evento 2");
      
      emit(PaisSetState(event.codigo, event.paises));
      final posts = await _fetchPosts(state.paises.length, event.codigo);
    }); */
    on<PaisesFiltro>(
      _actualizarPaises,
      transformer: throttleDroppable(throttleDuration),
    );
    
  }

  final http.Client httpClient;

    Future<void> _onPostFetched(PostFetched event,Emitter<PaisState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PaisStatus.initial) {
        print("****aca esta el problema");
        final posts = await _fetchPosts(state.codigo);
        return emit(state.copyWith(
          status: PaisStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      }
      print("evento 1");
      final posts = await _fetchPosts(state.codigo);
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: PaisStatus.success,
                posts: List.of(state.paises)..addAll(posts),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: PaisStatus.failure));
    }
  }


  Future<void> _actualizarPaises(PaisesFiltro event,Emitter<PaisState> emit) async {
    if (state.hasReachedMax) return;
    try {
      
      final posts = await _fetchPosts(event.codigo);
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
          status: PaisStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      
    } catch (_) {
      emit(state.copyWith(status: PaisStatus.failure));
    }
  } 

  

  Future<List<Pais>> _fetchPosts(String? codigo) async {
    final response = await httpClient.get(
      Uri.https(
        'api-turismo-backend.herokuapp.com',
        '/biblioteca/listar-paises/$codigo'
      ), 
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Pais(
          codigo: json['codigo'] as String,
          continente: json['continente'] as String,
          nombre: json['nombre'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}
