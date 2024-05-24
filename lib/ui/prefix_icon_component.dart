import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/bloc/search_bloc.dart';

class PrefixIcon extends StatelessWidget {
  final SearchBloc _bloc;

  const PrefixIcon(this._bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
        bloc: _bloc,
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is SearchLoading) {
            return Container(
              width: 10.0,
              height: 10.0,
              margin: const EdgeInsets.all(10.0),
              child: const CircularProgressIndicator(
                color: Colors.green,
                strokeWidth: 2.0,
              ),
            );
          }
          return const Icon(Icons.search);
        });
  }
}