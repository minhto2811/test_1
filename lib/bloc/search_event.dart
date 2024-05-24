part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class OnClearText extends SearchEvent {}

final class OnChangeTextEvent extends SearchEvent {}

final class OpenGoogleMapEvent extends SearchEvent {
  final String position;

  OpenGoogleMapEvent(this.position);
}
