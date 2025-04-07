part of 'video_cubit.dart';

@immutable
sealed class VideoState {}

final class VideoInitial extends VideoState {}

class VideoInCall extends VideoState {}

class VideoConnected extends VideoState {
  final int uid;
  final int localUid;

  VideoConnected({required this.uid, required this.localUid});
}

class VideoConnecting extends VideoState {

  VideoConnecting();
}


class VideoDisconnected extends VideoState {}
class VideoInitialized extends VideoState {}
class VideoLocalJoined extends VideoState {
  final int localUid;
  VideoLocalJoined(this.localUid);
}



class VideoLoading extends VideoState {}


// class VideoSuccess extends VideoState {
//   final String message;
//   final int? localUid;
//   final int? remoteUid;
//   final bool isDuration;
//   final String duration;
//
//   VideoSuccess({this.message = '', this.localUid, this.remoteUid,required this.isDuration, required this.duration, });
// }

class VideoSuccess extends VideoState {
  final String message;
  final String duration;
  final bool isDuration;
  final int? localUid;
  final int? remoteUid;

   VideoSuccess({
    required this.message,
    required this.duration,
    required this.isDuration,
    required this.localUid,
    required this.remoteUid,
  });

  VideoSuccess copyWith({
    String? message,
    String? duration,
    bool? isDuration,
    int? localUid,
    int? remoteUid,
  }) {
    return VideoSuccess(
      message: message ?? this.message,
      duration: duration ?? this.duration,
      isDuration: isDuration ?? this.isDuration,
      localUid: localUid ?? this.localUid,
      remoteUid: remoteUid ?? this.remoteUid,
    );
  }
}

class VideoError extends VideoState {
  final String message;
  VideoError(this.message);
}

// class CallDurationUpdated extends VideoState {
//   final String duration;
//   CallDurationUpdated({required this.duration});
// }


class VideoMuted extends VideoState {
  final bool isMuted;
  VideoMuted(this.isMuted);
}

