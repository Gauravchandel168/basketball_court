part of 'agora_cubit.dart';

@immutable
sealed class AgoraState {}

final class AgoraInitial extends AgoraState {}






class AgoraLoading extends AgoraState {}

class AgoraConnected extends AgoraState {

  final List<int> remoteUids;

   AgoraConnected({required this.remoteUids});


}

class AgoraUserJoined extends AgoraState {

  final List<int> remoteUids;

   AgoraUserJoined({required this.remoteUids});


}

class AgoraUserLeft extends AgoraState {

  final List<int> remoteUids;

   AgoraUserLeft({required this.remoteUids});


}

class AgoraMuteStateChanged extends AgoraState {

  final bool isMuted;

   AgoraMuteStateChanged({required this.isMuted});


}

class AgoraSpeakerStateChanged extends AgoraState {

  final bool isSpeakerEnabled;

   AgoraSpeakerStateChanged({required this.isSpeakerEnabled});


}

class AgoraVideoStateChanged extends AgoraState {

  final bool isVideoEnabled;

   AgoraVideoStateChanged({required this.isVideoEnabled});


}

class AgoraCameraSwitched extends AgoraState {
  final bool isSwitchCamera;

  AgoraCameraSwitched({required this.isSwitchCamera});

}

class AgoraDisconnected extends AgoraState {}

class AgoraError extends AgoraState {

  final String message;

   AgoraError({required this.message});


}
