import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:test_1/bloc/search_bloc.dart';
import 'package:test_1/network/address_model.dart';

class ListResult extends StatelessWidget {
  final SearchBloc _bloc;

  const ListResult(this._bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
        bloc: _bloc,
        buildWhen: (previous, current) => current is SearchSuccess,
        builder: (context, state) {
          if (state is SearchSuccess) {
            return ShowList(
              terms: _bloc.text.split(' '),
              addressList: state.addresses,
              onPressed: (value) => _bloc.add(OpenGoogleMapEvent(value)),
            );
          }
          return const SizedBox();
        });
  }
}

class ShowList extends StatelessWidget {
  final List<AddressModel> addressList;
  final void Function(String) onPressed;
  final List<String> terms;

  const ShowList(
      {super.key,
      required this.addressList,
      required this.onPressed,
      required this.terms});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: addressList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.location_on),
            title: SubstringHighlight(
              text: addressList[index].title,
              terms: terms,
            ),
            trailing: IconButton(
              onPressed: () => onPressed(addressList[index].title),
              icon: const Icon(Icons.directions),
            ),
          );
        });
  }
}
