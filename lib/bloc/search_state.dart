part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}
final class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}

final class OnChangeText extends SearchState {
  final String text;
  OnChangeText(this.text);
}

final class SearchSuccess extends SearchState {
  final List<AddressModel> addresses;
  SearchSuccess(this.addresses);
}
