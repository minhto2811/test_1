import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:test_1/network/address_model.dart';
import 'package:test_1/network/api_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiService _apiService;

  SearchBloc(this._apiService) : super(SearchInitial()) {
    on<OnChangeTextEvent>(_onChangeTextEvent);
    on<OnClearText>(_onClearText);
    on<OpenGoogleMapEvent>(_openGoogleMapEvent);
  }

  final TextEditingController textEditingController = TextEditingController();

  String get text => textEditingController.text;

  Future<void> _openGoogleMapEvent(
      OpenGoogleMapEvent event, Emitter<SearchState> emit) async {
    await MapsLauncher.launchQuery(event.position);
  }

  Future<void> _onChangeTextEvent(
      OnChangeTextEvent event, Emitter<SearchState> emit) async {
    emit(OnChangeText(text));
    if (text.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 300));
      emit(SearchSuccess(const []));
      return;
    }
    await Future.delayed(const Duration(seconds: 1));
    emit(SearchLoading());
    try {
      final result = await _apiService.searchByText(text);
      emit(SearchSuccess(result));
    } on IOException catch (e) {
      debugPrint(e.toString());
      emit(SearchError('No Internet Connection'));
    } on DioException catch (e) {
      debugPrint(e.toString());
      emit(SearchError('Connect timeout'));
    }
  }

  void _onClearText(OnClearText event, Emitter<SearchState> emit) {
    emit(OnChangeText(''));
    emit(SearchSuccess(const []));
    textEditingController.clear();
  }

  @override
  Future<void> close() {
    textEditingController.dispose();
    return super.close();
  }
}
