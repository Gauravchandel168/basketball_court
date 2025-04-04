part of 'video_cubit.dart';

@immutable
sealed class VideoState {}

final class VideoInitial extends VideoState {}
class VideoLoading extends VideoState {}

class VideoInCall extends VideoState {}

class VideoConnected extends VideoState {
  final int uid;
  final int localUid;

  VideoConnected({required this.uid, required this.localUid});
}

class VideoMuted extends VideoState {
  final bool isMuted;
  VideoMuted(this.isMuted);
}

class VideoDisconnected extends VideoState {}
class VideoInitialized extends VideoState {}
class VideoLocalJoined extends VideoState {
  final int localUid;
  VideoLocalJoined(this.localUid);
}

class VideoError extends VideoState {
  final String message;
  VideoError(this.message);
}
