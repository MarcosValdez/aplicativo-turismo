import 'package:aplicativo_turismo/Turismo/bloc/pais_bloc.dart';
import 'package:aplicativo_turismo/Turismo/widgest/bottom_loader.dart';
import 'package:aplicativo_turismo/Turismo/widgest/pais_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaisList extends StatefulWidget {
  @override
  _PaisListState createState() => _PaisListState();
}

class _PaisListState extends State<PaisList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaisBloc, PaisState>(
      builder: (context, state) {
        switch (state.status) {
          case PaisStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case PaisStatus.success:
            if (state.paises.isEmpty) {
              return const Center(child: Text('no posts'));
            }

            return SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.paises.length
                          ? BottomLoader()
                          : PaisListItem(post: state.paises[index]);
                    },
                  )
                ],
              ),
            );

          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<PaisBloc>().add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
