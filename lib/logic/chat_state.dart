part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class ChatConnected extends ChatState {}

class ChatMessageReceived extends ChatState {
  final String text;
  final bool isSentByUser;

  ChatMessageReceived({required this.text, required this.isSentByUser});
}

class ChatError extends ChatState {
  final String error;
  ChatError(this.error);
}