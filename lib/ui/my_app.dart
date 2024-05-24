import 'package:flutter/material.dart';
import 'package:test_1/bloc/search_bloc.dart';
import 'package:test_1/di/app_module.dart';
import 'package:test_1/theme/typography.dart';
import 'package:test_1/ui/list_address.dart';
import 'package:test_1/ui/prefix_icon_component.dart';
import 'package:test_1/ui/suffix_icon_component.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.green)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _bloc = getIt<SearchBloc>();

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          SearchView(_bloc),
          ListResult(_bloc),
        ],
      ),
    )));
  }
}

class SearchView extends StatelessWidget {
  final SearchBloc _bloc;

  const SearchView(this._bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.grey.shade300,
      child: TextField(
        controller: _bloc.textEditingController,
        keyboardType: TextInputType.text,
        onChanged: (text) => _bloc.add(OnChangeTextEvent()),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16.0),
          hintText: 'Enter Keyword',
          hintStyle: body?.copyWith(color: Colors.grey),
          border: InputBorder.none,
          suffixIcon: SuffixIcon(_bloc),
          prefixIcon: PrefixIcon(_bloc),
        ),
        textInputAction: TextInputAction.search,
        maxLines: 1,
        autocorrect: true,
      ),
    );
  }
}
