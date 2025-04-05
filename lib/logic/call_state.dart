part of 'call_cubit.dart';

@immutable
sealed class CallState {}

final class CallInitial extends CallState {}

class CallJoined extends CallState {}

class CallLeft extends CallState {}
