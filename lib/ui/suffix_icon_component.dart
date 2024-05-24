import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/bloc/search_bloc.dart';

class SuffixIcon extends StatelessWidget {
  final SearchBloc _bloc;

  const SuffixIcon(this._bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: _bloc,
      buildWhen: (previous, current) =>
      current is OnChangeText || current is SearchInitial,
      builder: (context, state) {
        if (state is OnChangeText && state.text.isNotEmpty) {
          return IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => _bloc.add(OnClearText()),
          );
        }
        return const SizedBox();
      },
    );
  }
}